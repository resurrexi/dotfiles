if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  -- enable autotag for nvim-ts-autotag plugin
  autotag = {
    enable = true,
  },
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "toml",
    "json",
    "yaml",
    "html",
    "scss",
    "python"
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.javascript.used_by = { "javascript", "javascriptreact" }
parser_config.tsx.used_by = { "typescriptreact" }
parser_config.typescript.used_by = { "typescript" }
EOF
