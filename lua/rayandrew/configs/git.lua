-- Gitsigns
-- See `:help gitsigns.txt`
local gitsigns_status, gitsigns = pcall(require, "gitsigns")

if gitsigns_status then
  gitsigns.setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  })
end
