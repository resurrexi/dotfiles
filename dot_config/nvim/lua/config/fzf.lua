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
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap=true, silent=true})
end

mapper("n", "<leader>o", "<Cmd>FzfLua files<CR>")
