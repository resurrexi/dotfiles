local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

-- Delete without registering
mapper("n", "x", [["_x]])
mapper("n", "X", [["_X]])

-- Visual replace without registering
mapper("v", "P", [["_dP]])

-- Clear highlighted text
mapper("n", "<Esc><Esc>", ":noh<CR>")

-- Split window
mapper("n", "<C-w><C-d>", ":new<CR>")
mapper("n", "<C-w><C-r>", ":vnew<CR>")

-- Get out of terminal input
mapper("t", "<Esc><Esc><Esc>", [[<C-\><C-n>]])

-- Allow gf to open non-existent files
mapper("n", "gf", ":edit <cfile><CR>")

-- Reselect visual selection after indenting
mapper("v", ">", ">gv")
mapper("v", "<", "<gv")

-- Yank to end of line (like D or C)
mapper("n", "Y", "y$")

-- Copy-to/Paste-from clipboard
mapper("v", "<Leader>y", [["*y]])
mapper("n", "<Leader>p", [["*p]])
mapper("v", "<Leader>p", [["*P]])

-- Center search jumps
mapper("n", "n", "nzz")
mapper("n", "N", "Nzz")

-- Buffer jumping and management
mapper("n", "<C-k>", ":bn<CR>")
mapper("n", "<C-j>", ":bp<CR>")

-- Moving lines
mapper("n", "<A-j>", ":m .+1<CR>==")
mapper("n", "<A-k>", ":m .-2<CR>==")
mapper("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
mapper("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
mapper("v", "<A-j>", ":m '>+1<CR>gv=gv")
mapper("v", "<A-k>", ":m '<-2<CR>gv=gv")
