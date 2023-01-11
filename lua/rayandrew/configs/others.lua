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

-- Enable colorizer
local colorizer_status, colorizer = pcall(require, "colorizer")

if colorizer_status then
  colorizer.setup({})
end

-- Nvim Surround
local nvim_surround_status, nvim_surround = pcall(require, "nvim_surround")
if nvim_surround_status then
  nvim_surround.setup({
    keymaps = {
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "ys",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
  })
end
