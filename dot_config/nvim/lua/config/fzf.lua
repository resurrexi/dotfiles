require("fzf-lua").setup({
  winopts = {
    preview = {
      hidden = true
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

-- Set keymaps
local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<leader>ff", "<Cmd>FzfLua files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", opts)
