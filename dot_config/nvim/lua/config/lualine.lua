require("lualine").setup({
  options = {
    icons_enabled = true, -- uses web-devicons
    theme = "auto",
    section_separators = {left = "", right = ""},
    component_separators = {left= "", right = ""},
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {
      "branch",
      {
        "filename",
        file_status = true,
        path = 1 -- relative path
      }
    },
    lualine_c = {"b:gitsigns_status"},
    lualine_x = {
      {
        "diagnostics",
        sources = {"nvim_diagnostic"},
        symbols = {error = " ", warn = " ", info = " ", hint = " "}
      }
    },
    lualine_y = {"filetype"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1 -- relative path
      }
    },
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {"filename"},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {"tabs"}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})
