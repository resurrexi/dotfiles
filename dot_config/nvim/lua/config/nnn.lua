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
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

mapper("n", "<leader>f", "<Cmd>NnnPicker<CR>")
mapper("n", "<leader>.", "<Cmd>NnnPicker $XDG_DATA_HOME/chezmoi<CR>")
