local status, lualine = pcall(require, "nvim-ts-autotag")
if (not status) then return end

require('nvim-ts-autotag').setup()
