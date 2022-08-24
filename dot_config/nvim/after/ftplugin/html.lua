vim.bo.autoindent = false  -- use TS indent

local group = vim.api.nvim_create_augroup("HTML Wrap Settings", { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {
    "*.htm",
    "*.html",
  },
  group = group,
  command = "setlocal wrap"
})
