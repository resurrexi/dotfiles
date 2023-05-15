require("rust-tools").setup({
  server = {
    on_attach = require("config.lsp_attach").on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        }
      }
    }
  }
})
