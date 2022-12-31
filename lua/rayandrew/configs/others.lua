-- Enable Comment.nvim
local comment_status, comment = pcall(require, "Comment")

if comment_status then
  comment.setup({})
end

-- Enable which key
local which_key_status, which_key = pcall(require, "which-key")

if which_key_status then
  which_key.setup({})
end
