lua << EOF
local builtin = require("nnn").builtin

require("nnn").setup({
  explorer = {
    cmd = "nnn -Go",
    session = "shared"
  },
  picker = {
    cmd = "nnn -Go"
  },
  mappings = {
    { "<C-p>", builtin.cd_to_path },
    { "<C-t>", builtin.open_in_tab },
    { "<C-x>", builtin.open_in_split },
    { "<C-v>", builtin.open_in_vsplit }
  }
})
EOF

" key maps
nnoremap <silent> <leader>f <Cmd>NnnPicker<CR>
nnoremap <silent> <leader>. <Cmd>NnnPicker $XDG_DATA_HOME/chezmoi<CR>
