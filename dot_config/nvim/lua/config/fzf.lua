require("fzf-lua").setup({
  keymap = {
    builtin = {
      ["?"] = "toggle-preview",
      ["<C-j>"] = "preview-page-down",
      ["<C-k>"] = "preview-page-up"
    }
  }
})

-- Set keymaps
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end
