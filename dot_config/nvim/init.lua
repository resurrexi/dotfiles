-- Disable shada file (optimization)
vim.opt.shadafile = "NONE"

-- Essentials
vim.g.mapleader = ","
vim.g.builtin_lsp = true

-- Behaviors
vim.opt.belloff = "all"
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- for nvim-cmp
vim.opt.swapfile = false
vim.opt.inccommand = "split"
vim.opt.hidden = true
vim.opt.updatetime = 300
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus" -- default y/p to use clipboard

-- Indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Colors
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Look and feel
vim.opt.title = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.list = true
vim.opt.listchars = {
  tab = "»·",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
  trail = "·"
}
vim.opt.scrolloff=10
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.joinspaces = false

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Optimizations
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin"
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Load lua files
require("plugins")
require("mappings")

-- Re-enable shadafile
vim.opt.shadafile = ""
