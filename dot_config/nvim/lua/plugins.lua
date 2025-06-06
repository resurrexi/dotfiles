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
    event = "InsertEnter",
    opts = {
      disable_filetype = {"TelescopePrompt"},
    }
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VimEnter", -- doesn't work with InsertEnter
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true
  },
  {
    "numToStr/Comment.nvim",
    event = {
      "BufNewFile",
      "BufReadPre",
    },
    config = true
  },
  {
    "luukvbaal/nnn.nvim",
    event = "VimEnter",
    config = function()
      require("config.nnn")
    end
  },
  {
    "ibhagwan/fzf-lua",
    event = "VimEnter",
    dependencies = {
      { "junegunn/fzf", lazy = true, build = "./install --bin" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.fzf")
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VimEnter",
    config = function()
      require("config.toggleterm")
    end
  },
  { "lambdalisue/suda.vim" },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      "CmdlineEnter" -- to allow loading for cmdline after startup
    },
    dependencies = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      {"L3MON4D3/LuaSnip", version = "v2.*"},
      "saadparwaiz1/cmp_luasnip",
      {
        "MattiasMTS/cmp-dbee", -- cmp extension for nvim-dbee
        ft = "sql",
        opts = {}, -- needed
      },
      opts = {
        sources = {
          {"cmp-dbee"} -- cmp extension for nvim-dbee
        }
      }
    },
    config = function()
      require("config.cmp")
    end
  },

  -- Motion
  {
    "ggandor/lightspeed.nvim",
    event = {
      "BufNewFile",
      "BufReadPre",
    },
    config = true
  },

  -- Aesthetics
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    main = "ibl",
    opts = {
      scope = { enabled = false }
    }
  },
  { "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = true
  },
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
    event = {
      "BufNewFile",
      "BufReadPre",
    },
    config = function()
      require("config.gitsigns")
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = {
      "BufNewFile",
      "BufReadPre",
    },
    opts = {
      filetypes = {
        "*", -- highlight all filetypes
        "!vim", -- but exclude vim
        "!lua", -- and exclude lua
        css = { rgb_fn = true }
      },
      user_default_options = {
        RRGGBBAA = true,
        tailwind = true,
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
    ft = { "markdown" },
    opts = {
      border = "single",
      width = 256,
      height = 128,
      pager = false
    }
  },
  {
    "mickael-menu/zk-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("config.zknvim")
    end
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup()
    end,
  },

  -- Language support
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = "BufEnter",
    config = function()
      require("codeium").setup({
        enable_chat = true
      })
    end
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "rust" },
    config = function()
      require("config.rust-tools")
    end
  },
  {
    "TovarishFin/vim-solidity",
    ft = { "solidity" }
  },
  {
    "prisma/vim-prisma",
    ft = { "prisma" }
  },
})
