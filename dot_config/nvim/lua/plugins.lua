-- Bootstrap lazy.nvim if necessary
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Init setup
require("lazy").setup({
  -- LSP and friends
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lspconfig")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end
  },

  -- Essentials
  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = {"TelescopePrompt"},
    }
  },
  { "windwp/nvim-ts-autotag" },
  { "numToStr/Comment.nvim" },
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("config.nnn")
    end
  },
  {
    "junegunn/fzf",
    build = "./install --bin" -- install fzf if not exists
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.fzf")
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("config.toggleterm")
    end
  },
  { "lambdalisue/suda.vim" },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("config.cmp")
    end
  },

  -- Motion
  { "ggandor/lightspeed.nvim" },

  -- Aesthetics
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_current_context = true,
    }
  },
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "projekt0n/github-nvim-theme"
    },
    config = function()
      require("config.lualine")
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "*", -- highlight all filetypes
        "!vim", -- but exclude vim
        "!lua", -- and exclude lua
        css = {rgb_fn = true}
      },
      user_default_options = {
        RRGGBBAA = true
      }
    }
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- load during startup
    priority = 1000, -- load before other plugins
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          hide_nc_statusline = false,
          terminal_colors = false
        }
      })
      vim.cmd("colorscheme github_dark")
    end
  },

  -- Misc
  {
    "ellisonleao/glow.nvim",
    opts = {
      install_path = vim.env.HOME .. "/bin",
      border = "single",
      pager = true
    }
  },
  {
    "mickael-menu/zk-nvim",
    dependencies = {"neovim/nvim-lspconfig"},
    config = function()
      require("config.zknvim")
    end
  },

  -- Language support
  {
    "simrat39/rust-tools.nvim",
    dependencies = {"neovim/nvim-lspconfig"},
    config = function()
      require("config.rust-tools")
    end
  },
  { "TovarishFin/vim-solidity" },
  { "prisma/vim-prisma" },
})
