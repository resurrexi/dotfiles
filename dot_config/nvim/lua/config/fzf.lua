require("fzf-lua").setup({
  preview_opts = "hidden",
  keymap = {
    builtin = {
      ["?"] = "toggle-preview",
      ["<C-f>"] = "preview-page-down",
      ["<C-b>"] = "preview-page-up"
    }
  }
})
