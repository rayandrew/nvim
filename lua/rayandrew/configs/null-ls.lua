-- null-ls
-- to setup format on save
local null_ls_status, null_ls = pcall(require, "null-ls")

if not null_ls_status then
  return
end

local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local code_actions = null_ls.builtins.code_actions -- to setup code actions
local completion = null_ls.builtins.completion -- to setup completions

local lsp_formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
  debug = false,
  -- setup formatters & linters
  sources = {
    completion.spell,
    formatting.prettier.with({
      extra_filetypes = { "svelte" },
    }), -- js/ts formatter
    formatting.stylua, -- lua formatter
    diagnostics.eslint_d.with({ -- js/ts linter
      -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.cjs") -- change file extension if you use something else
      end,
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
      },
    }),
    code_actions.eslint_d.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
      },
    }),
    code_actions.gitsigns,
    -- php
    diagnostics.php,
    -- diagnostics.phpcs,
    -- diagnostics.phpstan,
    formatting.blade_formatter,
    -- formatting.phpcsfixer,
    -- formatting.phpcbf,
    -- formatting.rustywind,
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = lsp_formatting_group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_formatting_group,
        buffer = bufnr,
        callback = function()
          -- print("HERE 1", current_client.name)
          -- vim.lsp.buf.formatting_sync()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(client)
              -- print("HERE 2", current_client.name, client.name)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})
