-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[packadd packer.nvim]])
end

local packer = require("packer")

packer.startup({
  function(use)
    -- Package manager
    use("wbthomason/packer.nvim")

    use("preservim/vimux")
    use("christoomey/vim-tmux-navigator")

    use("xiyaowong/nvim-transparent")

    use({ -- LSP Configuration & Plugins
      "neovim/nvim-lspconfig",
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Useful status updates for LSP
        "j-hui/fidget.nvim",

        -- Additional lua configuration, makes nvim stuff amazing
        "folke/neodev.nvim",

        {
          "glepnir/lspsaga.nvim",
          branch = "main",
        },
      },
    })

    use({ -- Autocompletion
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
    })

    use({ -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
    })

    use({ -- Additional text objects via treesitter
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    })

    use({
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
    })

    use({
      "nvim-treesitter/nvim-treesitter-context",
      after = "nvim-treesitter",
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        "jayp0521/mason-null-ls.nvim",
      },
    })

    use("nvim-tree/nvim-tree.lua")
    use("nvim-tree/nvim-web-devicons")

    -- Git related plugins
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")

    -- use 'navarasu/onedark.nvim' -- Theme inspired by Atom
    -- use("NTBBloodbath/doom-one.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })

    use("nvim-lualine/lualine.nvim") -- Fancier statusline
    use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
    use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
    use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder (files, lsp, etc)
    use({
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      requires = {
        "nvim-lua/plenary.nvim",
        -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 },
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
    })

    -- use("Github/copilot.vim")
    use({
      "zbirenbaum/copilot.lua",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function()
          require("copilot").setup({
            suggestion = {
              keymap = {
                accept = "<c-g>",
                accept_word = false,
                accept_line = false,
                next = "<c-j>",
                prev = "<c-k>",
                dismiss = "<c-f>",
              },
              -- auto_trigger = true,
            },
          })
        end, 100)
      end,
    })
    use({
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function()
        require("copilot_cmp").setup()
      end,
    })

    use({
      "akinsho/bufferline.nvim",
      tag = "v3.*",
      requires = "nvim-tree/nvim-web-devicons",
    })

    use("folke/which-key.nvim")
    use("mg979/vim-visual-multi")

    -- Laravel
    use("jwalton512/vim-blade")

    use("nathom/filetype.nvim")

    use({ "akinsho/toggleterm.nvim", tag = "*" })

    use("NvChad/nvim-colorizer.lua")

    use("onsails/lspkind.nvim")

    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    })

    if is_bootstrap then
      require("packer").sync()
    end
  end,
  {
    compile_path = require("packer.util").join_paths(vim.fn.stdpath("data"), "plugin", "packer_compiled.lua"),
  },
})

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = "plugins.lua",
  -- pattern = vim.fn.expand("$MYVIMRC"),
})
