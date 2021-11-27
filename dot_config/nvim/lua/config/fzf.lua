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

-- Set keymaps
local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<leader>o", "<Cmd>FzfLua files<CR>", opts)
