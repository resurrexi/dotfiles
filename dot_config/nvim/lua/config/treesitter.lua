require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      "markdown"
    },
  },
  indent = {
    enable = true,
    disable = {
      "python",
      "yaml"
    },
  },
  -- "all", "maintained", or a list
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "python",
    "rust",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  }
})
