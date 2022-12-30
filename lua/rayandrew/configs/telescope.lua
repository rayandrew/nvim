-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local status, telescope = pcall(require, "telescope")

if not status then
  return
end

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "live_grep_args")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
