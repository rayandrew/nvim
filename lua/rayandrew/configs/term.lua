local toggleterm_status, toggleterm = pcall(require, "toggleterm")
local wk_status, wk = pcall(require, "which-key")
if not toggleterm_status and not wk_status then
  return
end

toggleterm.setup({})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

local htop = Terminal:new({
  cmd = "htop",
  hidden = true,
  direction = "float",
})

wk.register({
  ["<leader>"] = {
    t = {
      name = "+term",
      f = { "<cmd> :ToggleTerm direction=float<CR>", "[T]erm [F]loat" },
      t = { "<cmd> :ToggleTerm direction=tab<CR>", "[T]erm [T]ab" },
      h = { "<cmd> :ToggleTerm direction=horizontal<CR>", "[T]erm [H]orizontal" },
      v = { "<cmd> :ToggleTerm direction=vertical<CR>", "[T]erm [V]ertical" },
    },
    g = {
      name = "+git",
      g = {
        function()
          lazygit:toggle()
        end,
        "Lazy[G]it",
      },
      l = {
        function()
          lazygit:toggle()
        end,
        "[L]azy[G]it",
      },
    },
    h = {
      function()
        htop:toggle()
      end,
      "[H]top",
    },
  },
  ["<c-`>"] = { "<cmd> :ToggleTerm direction=horizontal<CR>", "[T]erm [H]orizontal" },
})
