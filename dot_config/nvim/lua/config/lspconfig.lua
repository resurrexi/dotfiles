local nvim_lsp = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Change diagnostic symbols
local signs = { Error = "■", Warning = "■", Hint = "■", Information = "■" }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Transparent bg on diagnostics
vim.cmd([[
augroup DiagnosticColors
au!
au ColorScheme * hi LspDiagnosticsDefaultError ctermbg=none guibg=none
au ColorScheme * hi LspDiagnosticsDefaultWarning ctermbg=none guibg=none
au ColorScheme * hi LspDiagnosticsDefaultInformation ctermbg=none guibg=none
au ColorScheme * hi LspDiagnosticsDefaultHint ctermbg=none guibg=none
augroup
]])

-- Customize diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    update_in_insert = true
  }
)

-- Setup attach method for each buffer
local on_attach = function(client, bufnr)
  local lsp_mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      mode,
      key,
      "<Cmd>lua " .. result .. "<CR>",
      { noremap = true, silent = true }
    )
  end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  lsp_mapper("n", "K", "vim.lsp.buf.hover()")
  lsp_mapper("n", "gd", "vim.lsp.buf.definition()")
  lsp_mapper("n", "gr", "vim.lsp.buf.references()")
  lsp_mapper("n", "gn", "vim.lsp.buf.type_definition()")
  lsp_mapper("n", "<leader>rn", "vim.lsp.buf.rename()")
  lsp_mapper("n", "<leader>ca", "vim.lsp.buf.code_action()")
  lsp_mapper("n", "<leader>]", "vim.diagnostic.goto_next()")
  lsp_mapper("n", "<leader>[", "vim.diagnostic.goto_prev()")
  lsp_mapper("i", "<C-k>", "vim.lsp.buf.signature_help()")

  -- Auto-format on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
    augroup Format
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
    augroup end
    ]])
  end
end

-- LSP servers
nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = cmp_capabilities
})
nvim_lsp.pyright.setup({
  on_attach = on_attach,
  capabilities = cmp_capabilities
})
nvim_lsp.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = cmp_capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self"
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      checkOnSave = {
        command = "clippy"
      },
      procMacro = {
        enable = true
      },
    }
  }
})
nvim_lsp.solidity_ls.setup({
  on_attach = on_attach,
  capabilities = cmp_capabilities
})

-- Setup diagnostic clients
-- https://github.com/iamcco/coc-diagnostic/blob/master/src/config.ts
nvim_lsp.diagnosticls.setup({
  on_attach = on_attach,
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
    'solidity'
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
        debounce = 100,
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
        debounce = 100,
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
      solhint = {
        command = './node_modules/.bin/solhint',
        rootPatterns = {
          '.solhint.json',
        },
        debounce = 100,
        args = { '--formatter', 'stylish', '%filepath' },
        sourceName = 'solhint',
        offsetLine = 2,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          '^[ \t]{2,}(\\d+):(\\d+)[ \t]{2,}([a-z]+?)[ \t]{2,}(.*)[ \t]{2,}[a-z-]+$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        securities = {
          error = 'error',
          warning = 'warning'
        }
      }
    },
    filetypes = {
      python = { 'pylint', 'flake8' },
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
      solidity = 'solhint'
    },
    formatters = {
      prettier = {
        command = './node_modules/.bin/prettier',
        args = { '--stdin', '--stdin-filepath', '%filepath' },
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
      }
    },
    formatFiletypes = {
      python = 'black',
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
      solidity = 'prettier'
    }
  }
})
