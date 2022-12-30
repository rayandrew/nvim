-- Enable Comment.nvim
pcall(require("Comment").setup)

-- Enable which key
local which_key_status, which_key = pcall(require, "which-key")

if which_key_status then
  which_key.setup({})
end
