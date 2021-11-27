require("toggleterm").setup({
  size = function(term)
    local stats = vim.api.nvim_list_uis()[1]
    local winWidth = stats.width
    local winHeight = stats.height

    if term.direction == "horizontal" then
      return winHeight / 3
    elseif term.direction == "vertical" then
      return winWidth / 3
    else
      return 9
    end
  end,
  open_mapping = [[<C-\>]],
  insert_mappings = false,
  persist_size = true,
  close_on_exit = true
})

-- Setup lazygit term
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float"
})

function _lazygit_toggle()
  lazygit:toggle()
end

-- Set keymaps
local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<leader>lg", "<Cmd>lua _lazygit_toggle()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", opts)
