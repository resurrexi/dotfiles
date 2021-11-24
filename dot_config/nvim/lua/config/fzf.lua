require("fzf-lua").setup({
  winops = {
    preview = {
      hidden = "hidden"
    }
  },
  keymap = {
    builtin = {
      ["?"] = "toggle-preview",
      ["<C-f>"] = "preview-page-down",
      ["<C-b>"] = "preview-page-up"
    }
  }
})
