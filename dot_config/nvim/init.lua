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

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

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

require("plugins")
require("mappings")
