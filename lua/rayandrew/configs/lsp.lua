-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.

  local lspmap = function(mode)
    return function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end
  end

  local nmap = lspmap("n")
  local nvmap = lspmap({ "n", "v" })

  -- nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>rn", "<cmd>Lspsaga rename<CR>", "[R]e[n]ame")
  -- nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nvmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")

  nmap("<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", "[L]ine [D]iagnostics")
  nmap("<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "[C]ursor [D]iagnostics")

  -- nmap("[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", )
  -- nmap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

  -- nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gd", "<cmd>Lspsaga peek_definition<CR>", "[G]oto [D]efinition")
  -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gr", "<cmd>Lspsaga lsp_finder<CR>", "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>pa", vim.lsp.buf.add_workspace_folder, "[P]roject [A]dd Folder")
  nmap("<leader>pr", vim.lsp.buf.remove_workspace_folder, "[P]roject [R]emove Folder")
  nmap("<leader>pl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[P]roject [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  ["awk_ls"] = {},
  bashls = {},
  clangd = {},
  -- gopls = {},
  pyright = {},
  eslint = {},
  -- rust_analyzer = {},
  tsserver = {},
  tailwindcss = {},
  yamlls = {},

  -- intelephense = {},
  -- phpactor = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
local neodev_status, neodev = pcall(require, "neodev")

if neodev_status then
  neodev.setup({})
end

--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()

local nvim_cmp_lsp_status, nvim_cmp_lsp = pcall(require, "nvim_cmp_lsp")

if nvim_cmp_lsp_status then
  capabilities = nvim_cmp_lsp.default_capabilities(capabilities)
end

-- Setup mason so it can manage external tooling
local mason_status, mason = pcall(require, "mason")
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if mason_status and mason_lspconfig_status then
  mason.setup()

  -- Ensure the servers above are installed

  mason_lspconfig.setup({
    automatic_installation = true,
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      })
    end,
  })
end

-- Turn on lsp status information
-- pcall(require("fidget").setup)

-- nvim-cmp setup
local cmp_status, cmp = pcall(require, "cmp")
local luasnip_status, luasnip = pcall(require, "luasnip")
local lspkind_status, lspkind = pcall(require, "lspkind")

if cmp_status and luasnip_status and lspkind_status then
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "copilot" },
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        symbol_map = { Copilot = "" },
      }),
    },
  })
end

local saga_status, saga = pcall(require, "lspsaga")

if saga_status then
  saga.init_lsp_saga({
    custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    symbol_in_winbar = {
      in_custom = true,
    },
  })
end
