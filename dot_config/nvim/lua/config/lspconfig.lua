local nvim_lsp = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_flags = {
  debounce_text_changes = 150,
}

-- Transparent bg on diagnostics
vim.cmd([[
augroup DiagnosticColors
au!
au ColorScheme * hi DiagnosticError ctermbg=none guibg=none
au ColorScheme * hi DiagnosticWarn ctermbg=none guibg=none
au ColorScheme * hi DiagnosticInfo ctermbg=none guibg=none
au ColorScheme * hi DiagnosticHint ctermbg=none guibg=none
augroup
]])

-- Customize diagnostics
vim.diagnostic.config({
  float = {
    source = "if_many",
  },
  virtual_text = false,
  severity_sort = true,
  update_in_insert = true,
  -- change diagnostic symbols
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "■",
      [vim.diagnostic.severity.WARN] = "■",
      [vim.diagnostic.severity.HINT] = "■",
      [vim.diagnostic.severity.INFO] = "■",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

-- LSP servers
nvim_lsp.ts_ls.setup({
  on_attach = require("config.lsp_attach").on_attach,
  capabilities = cmp_capabilities,
  flags = lsp_flags,
})
nvim_lsp.pyright.setup({
  on_attach = require("config.lsp_attach").on_attach,
  capabilities = cmp_capabilities,
  flags = lsp_flags,
})
nvim_lsp.solidity_ls.setup({
  on_attach = require("config.lsp_attach").on_attach,
  capabilities = cmp_capabilities,
  flags = lsp_flags,
})
nvim_lsp.prismals.setup({
  on_attach = require("config.lsp_attach").on_attach,
  capabilities = cmp_capabilities,
  flags = lsp_flags,
})
nvim_lsp.tailwindcss.setup({
  on_attach = require("config.lsp_attach").on_attach,
  capabilities = cmp_capabilities,
  flags = lsp_flags,
})

-- Setup diagnostic clients
-- https://github.com/iamcco/coc-diagnostic/blob/master/src/config.ts
nvim_lsp.diagnosticls.setup({
  on_attach = require("config.lsp_attach").on_attach,
  filetypes = {
    'python',
    'javascript',
    'javascriptreact',
    'json',
    'typescript',
    'typescriptreact',
    'css',
    'less',
    'scss',
    'markdown',
    'solidity',
    'sql'
  },
  init_options = {
    linters = {
      eslint = {
        command = './node_modules/.bin/eslint',
        rootPatterns = {
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json',
          'package.json'
        },
        debounce = 500,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
      pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        debounce = 500,
        args = {
          '--output-format',
          'text',
          '--score',
          'no',
          '--msg-template',
          "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'",
          '%file'
        },
        formatPattern = {
          "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        rootPatterns = { '.git', 'pyproject.toml', 'setup.py', '.pylintrc' },
        securities = {
          informational = 'hint',
          refactor = 'info',
          convention = 'info',
          warning = 'warning',
          error = 'error',
          fatal = 'error'
        },
        offsetColumn = 1,
        formatLines = 1
      },
      flake8 = {
        command = 'flake8',
        debounce = 500,
        args = { '--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s', '-' },
        rootPatterns = { '.flake8', 'setup.cfg', 'tox.ini' },
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'flake8',
        formatLines = 1,
        formatPattern = {
          '(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        securities = {
          W = 'warning',
          E = 'error',
          F = 'error',
          C = 'error',
          N = 'error'
        }
      },
      ruff = {
        command = 'ruff',
        debounce = 500,
        args = { 'check', '--output-format', 'json', '%filepath' },
        rootPatterns = { 'pyproject.toml', 'ruff.toml' },
        sourceName = 'ruff',
        parseJson = {
          line = 'location.row',
          column = 'location.column',
          endLine = 'end_location.row',
          endColumn = 'end_location.column',
          message = '${message} [${code}]',
          security = 'fix.applicability'
        },
        securities = {
          safe = 'warning',
          unsafe = 'error'
        }
      },
      solhint = {
        command = './node_modules/.bin/solhint',
        rootPatterns = {
          '.solhint.json',
        },
        debounce = 500,
        args = { '--formatter', 'unix', '%filepath' },
        sourceName = 'solhint',
        offsetLine = 0,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^\\[]+)\\[([A-z]+)\\/?[a-z-]*\\]$',
          {
            line = 1,
            column = 2,
            security = 4,
            message = 3
          }
        },
        securities = {
          Error = 'error',
          Warning = 'warning'
        }
      }
    },
    filetypes = {
      python = { 'pylint', 'flake8', 'ruff' },
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
      solidity = 'solhint'
    },
    formatters = {
      prettier = {
        command = './node_modules/.bin/prettier',
        args = { '--stdin-filepath', '%filepath' },
        rootPatterns = {
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.toml',
          '.prettierrc.json',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.json5',
          '.prettierrc.js',
          '.prettierrc.cjs',
          'prettier.config.js',
          'prettier.config.cjs'
        }
      },
      black = {
        command = 'black',
        args = { '--quiet', '-' },
        rootPatterns = { 'pyproject.toml' }
      },
      isort = {
        command = 'isort',
        args = { '--quiet', '-' },
        rootPatterns = { 'pyproject.toml', '.isort.cfg' }
      },
      ruff_fmt = {
        command = 'ruff',
        args = { 'format', '--quiet', '-' },
        rootPatterns = { 'pyproject.toml', 'ruff.toml' }
      },
      ruff_isort = {
        command = 'ruff',
        args = { 'check', '--select', 'I', '--fix', '--quiet', '-' },
        rootPatterns = { 'pyproject.toml', 'ruff.toml' }
      },
      rustfmt = {
        command = 'rustfmt',
        rootPatterns = { 'Cargo.toml' }
      },
      sqlfmt = {
        command = 'sqlfmt',
        args = { '--quiet', '-' },
        rootPatterns = { 'dbt_project.toml' }
      }
    },
    formatFiletypes = {
      python = { 'black', 'isort', 'ruff_fmt', 'ruff_isort' },
      css = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier',
      json = 'prettier',
      markdown = 'prettier',
      solidity = 'prettier',
      rust = 'rustfmt',
      sql = 'sqlfmt'
    }
  }
})
