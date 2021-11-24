require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true
  },
  -- "all", "maintained", or a list
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "latex",
    "lua",
    "python",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  }
})
