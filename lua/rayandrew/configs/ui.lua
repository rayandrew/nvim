-- TokyoNight

local tokyonight_status, tokyonight = pcall(require, "tokyonight")
if tokyonight_status then
  vim.cmd.colorscheme("tokyonight-night")
  tokyonight.setup({
    transparent = true,
  })
end

-- Catppuccin
-- local catppuccin_status, catppuccin = pcall(require, "catppuccin")
-- if catppuccin_status then
--   vim.cmd.colorscheme("catppuccin")
--   catppuccin.setup({
--     flavour = "mocha", -- latte, frappe, macchiato, mocha
--     term_colors = true,
--     transparent_background = true,
--     no_italic = false,
--     no_bold = false,
--     styles = {
--       comments = {},
--       conditionals = {},
--       loops = {},
--       functions = {},
--       keywords = {},
--       strings = {},
--       variables = {},
--       numbers = {},
--       booleans = {},
--       properties = {},
--       types = {},
--     },
--     color_overrides = {
--       mocha = {
--         base = "#000000",
--       },
--     },
--     integrations = {
--       nvimtree = true,
--     },
--     highlight_overrides = {
--       mocha = function(C)
--         return {
--           TabLineSel = { bg = C.pink },
--           NvimTreeNormal = { bg = C.none },
--           CmpBorder = { fg = C.surface2 },
--           Pmenu = { bg = C.none },
--           NormalFloat = { bg = C.none },
--           TelescopeBorder = { link = "FloatBorder" },
--         }
--       end,
--     },
--   })
-- end

-- Transparent window
-- local transparent_status, transparent = pcall(require, "transparent")
--
-- if transparent_status then
--   transparent.setup({
--     enable = true, -- boolean: enable transparent
--     extra_groups = { -- table/string: additional groups that should be cleared
--       -- In particular, when you set it to 'all', that means all available groups
--
--       -- example of akinsho/nvim-bufferline.lua
--       "BufferLineTabClose",
--       "BufferlineBufferSelected",
--       "BufferLineFill",
--       "BufferLineBackground",
--       "BufferLineSeparator",
--       "BufferLineIndicatorSelected",
--     },
--     exclude = {}, -- table: groups you don't want to clear
--   })
-- end

-- Set lualine as statusline
-- See `:help lualine.txt`
local lualine_status, lualine = pcall(require, "lualine")

if lualine_status then
  lualine.setup({
    options = {
      icons_enabled = false,
      -- theme = "catppuccin",
      theme = "tokyonight",
      component_separators = "|",
      section_separators = "",
    },
  })
end

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
local indent_blankline_status, indent_blankline = pcall(require, "indent_blankline")

if indent_blankline_status then
  indent_blankline.setup({
    char = "┊",
    show_trailing_blankline_indent = false,
  })
end

-- nvim-tree
local nvimtree_status, nvimtree = pcall(require, "nvim-tree")

if nvimtree_status then
  -- change color for arrows in tree to light blue
  vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

  nvimtree.setup({
    -- change folder arrow icons
    renderer = {
      icons = {
        glyphs = {
          folder = {
            arrow_closed = "", -- arrow when folder is closed
            arrow_open = "", -- arrow when folder is open
          },
        },
      },
    },
    -- disable window_picker for
    -- explorer to work well with
    -- window splits
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },

    -- 	git = {
    -- 		ignore = false,
    -- 	},
  })
end

local bufferline_status, bufferline = pcall(require, "bufferline")

if bufferline_status then
  bufferline.setup({
    -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
    },
  })
end
