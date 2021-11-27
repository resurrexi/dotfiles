local builtin = require("nnn").builtin

require("nnn").setup({
  explorer = {
    cmd = "nnn -Go"
  },
  picker = {
    cmd = "nnn -Go",
    session = "shared"
  },
  mappings = {
    {"<C-t>", builtin.open_in_tab},
    {"<C-s>", builtin.open_in_split},
    {"<C-v>", builtin.open_in_vsplit}
  }
})

-- Set keymaps
local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<leader>f", "<Cmd>NnnPicker<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>.", "<Cmd>NnnPicker $XDG_DATA_HOME/chezmoi<CR>", opts)
