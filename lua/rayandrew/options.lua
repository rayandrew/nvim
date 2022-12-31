-- [[ Setting options ]]
-- See `:help vim.o`

-- Timeoutlen
vim.opt.timeoutlen = 500

if vim.g.neovide then
  vim.cmd(":cd ~")
end

-- Font
-- vim.o.guifont = "JetBrainsMono Nerd Font:h18"
vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h18" }

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
vim.o.pumblend = 15
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- remove trailing whitespace
local remove_spaces_group = vim.api.nvim_create_augroup("RemoveSpaces", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/s+$//e",
  group = remove_spaces_group,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
