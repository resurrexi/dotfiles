-- LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local lsp_mapper = function(mode, key, result)
      vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        key,
        "<Cmd>" .. result .. "<CR>",
        { noremap = true, silent = true }
      )
    end

    lsp_mapper("n", "K", "lua vim.lsp.buf.hover()")
    lsp_mapper("n", "gd", "lua vim.lsp.buf.definition()")
    lsp_mapper("n", "gds", "split | lua vim.lsp.buf.definition()")
    lsp_mapper("n", "gdi", "vsplit | lua vim.lsp.buf.definition()")
    lsp_mapper("n", "gr", "lua vim.lsp.buf.references()")
    lsp_mapper("n", "gn", "lua vim.lsp.buf.type_definition()")
    lsp_mapper("n", "gns", "split | lua vim.lsp.buf.type_definition()")
    lsp_mapper("n", "gni", "vsplit | lua vim.lsp.buf.type_definition()")
    lsp_mapper("n", "<leader>rn", "lua vim.lsp.buf.rename()")
    lsp_mapper("n", "<leader>ca", "lua vim.lsp.buf.code_action()")
    lsp_mapper("n", "<leader>]", "lua vim.diagnostic.goto_next()")
    lsp_mapper("n", "<leader>[", "lua vim.diagnostic.goto_prev()")
    lsp_mapper("i", "<C-k>", "lua vim.lsp.buf.signature_help()")

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Auto-format on save
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('UserFormatOnSave', {clear=false}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})

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
vim.lsp.enable("ts_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("prismals")
vim.lsp.enable("tailwindcss")

-- Setup diagnostic clients
-- https://github.com/iamcco/coc-diagnostic/blob/master/src/config.ts
vim.lsp.config('diagnosticls', {
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
      }
    },
    filetypes = {
      python = { 'pylint', 'ruff' },
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
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
      python = { 'ruff_fmt', 'ruff_isort' },
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
      rust = 'rustfmt',
      sql = 'sqlfmt'
    }
  }
})
vim.lsp.enable('diagnosticls')
