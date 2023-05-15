local M = {}

-- Setup attach method for each buffer
function M.on_attach(client, bufnr)
  local lsp_mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      mode,
      key,
      "<Cmd>" .. result .. "<CR>",
      { noremap = true, silent = true }
    )
  end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
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

  -- Auto-format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
    augroup Format
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ bufnr = bufnr })
    augroup end
    ]])
  end
end

return M
