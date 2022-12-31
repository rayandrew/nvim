-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- disable paste clipboard
vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

local wk_status, wk = pcall(require, "which-key")

if wk_status then
  wk.register({
    ["<leader>"] = {
      e = { vim.diagnostic.open_float, "Diagnostic Open Float" },
      q = { vim.diagnostic.setloclist, "Diagnostic Set Loc List" },
      ["?"] = { require("telescope.builtin").help_tags, "[?] Search Help" },
      ["<space>"] = { "<cmd> WhichKey <CR>", "[ ] Find Which Key" },
      ["/"] = {
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        "[/] Fuzzily search in current buffer]",
      },
      o = { "<cmd>Lspsaga outline<CR>", "[O]utline" },
      b = {
        name = "+buffer",
        d = { "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>", "[B]uffer [D]elete" },
        b = { require("telescope.builtin").buffers, "[B]rowse [B]uffers" },
      },
      f = {
        name = "+file",
        f = { require("telescope.builtin").find_files, "[F]ind [F]iles" },
        F = {
          function()
            require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
          end,
          "[F]ind [F]iles in current directory",
        },
        o = { require("telescope.builtin").oldfiles, "[F]ind recently [o]pened files" },
        s = { "<cmd> :w <CR>", "[F]ile [S]ave" },
        w = { function() end, "Nothing" },
      },
      s = {
        name = "+search",
        d = { require("telescope.builtin").diagnostics, "[S]earch [D]iagnostics" },
        f = { require("telescope.builtin").find_files, "[S]earch [F]iles" },
        h = { require("telescope.builtin").help_tags, "[S]earch [H]elp" },
        w = { require("telescope.builtin").grep_string, "[S]earch current [W]ord" },
        p = { require("telescope.builtin").live_grep, "[S]earch by gre[p]" },
        g = { require("telescope.builtin").live_grep, "[S]earch by [g]rep" },
        o = { require("telescope.builtin").oldfiles, "[S]earch recently [o]pened files" },
        G = {
          function()
            require("telescope").extensions.live_grep_args.live_grep_args({ cwd = vim.fn.expand("%:p:h") })
          end,
          "[S]earch by [G]rep in current directory",
        },
      },
      w = {
        name = "+window",
        s = { "<cmd> :split <CR>", "[W]indow Horizontal [S]plit" }, -- split horizontal
        v = { "<cmd> :vsplit <CR>", "[W]indow [V]ertical Split" }, -- split vertical
        h = { "<cmd> :TmuxNavigateLeft<CR>", "Go to Left [W]indow" },
        j = { "<cmd> :TmuxNavigateDown<CR>", "Go to [W]indow Below" },
        k = { "<cmd> :TmuxNavigateUp<CR>", "Go to Top [W]indow" },
        l = { "<cmd> :TmuxNavigateRight<CR>", "Go to Right [W]indow" },
        q = { "<C-w>q", "[W]indow [Q]uit" }, -- quit
      },
    },
    ["<c-p>"] = { require("telescope.builtin").find_files, "[F]ind [F]iles in VSCode style" },
    ["<c-n>"] = { "<cmd> NvimTreeFindFileToggle<CR>", "[N]vim Tree" },
    ["["] = {
      -- d = { vim.diagnostic.goto_prev, "[D]iagnostic Go to Prev" },
      e = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Diagnostic Go to Prev" },
      E = {
        function()
          require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        "Diagnostic Go to Prev [E]rror",
      },
    },
    ["]"] = {
      -- d = { vim.diagnostic.goto_next, "[D]iagnostic Go to Next" },
      e = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Diagnostic Go to Next" },
      E = {
        function()
          require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        "Diagnostic Go to Next [E]rror",
      },
    },
  }, { silent = true })
else
end
