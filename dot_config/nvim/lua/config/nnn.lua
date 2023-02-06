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
    {"<leader>t", builtin.open_in_tab},
    {"<leader>s", builtin.open_in_split},
    {"<leader>i", builtin.open_in_vsplit}
  }
})

-- Set keymaps
local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<leader>e", "<Cmd>NnnExplorer<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>f", "<Cmd>NnnPicker %:p:h<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>.", "<Cmd>NnnPicker $XDG_DATA_HOME/chezmoi<CR>", opts)
