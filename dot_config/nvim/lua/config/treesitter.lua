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
    "c",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "query",
    "rust",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml"
  }
})
