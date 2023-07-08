-- Bootstrap packer if necessary
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- Init setup
vim.cmd "packadd packer.nvim" -- load packer
local packer = require("packer")

packer.startup(
  function(use)
    -- Required dependencies
    use "wbthomason/packer.nvim"

    -- LSP and friends
    use {
      "neovim/nvim-lspconfig",
      config = [[require("config.lspconfig")]]
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = [[require("config.treesitter")]]
    }

    -- Essentials
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({
          disable_filetype = {"TelescopePrompt"}
        })
      end
    }
    use {
      "windwp/nvim-ts-autotag",
      event = "BufAdd", -- doesn't work with InsertEnter
      config = function()
        require("nvim-ts-autotag").setup()
      end
    }
    use {
      "numToStr/Comment.nvim",
      event = "BufAdd",
      config = function()
        require("Comment").setup()
      end
    }
    use {
      "luukvbaal/nnn.nvim",
      event = "VimEnter",
      config = [[require("config.nnn")]]
    }
    use {
      "junegunn/fzf",
      run = "./install --bin" -- install fzf if not exists
    }
    use {
      "ibhagwan/fzf-lua",
      event = "VimEnter",
      after = "nvim-web-devicons",
      requires = {
        "vijaymarupudi/nvim-fzf",
      },
      config = [[require("config.fzf")]]
    }
    use {
      "akinsho/toggleterm.nvim",
      tag = "*",
      event = "VimEnter",
      config = [[require("config.toggleterm")]]
    }
    use {
      "lambdalisue/suda.vim",
      event = "VimEnter"
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      event = {
        "InsertEnter",
        "CmdlineEnter" -- to allow loading for cmdline after startup
      },
      after = "nvim-lspconfig",
      requires = {
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-nvim-lsp",
        {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
        {"hrsh7th/cmp-path", after = "nvim-cmp"},
        {"hrsh7th/cmp-cmdline", after = "nvim-cmp"},
        {"saadparwaiz1/cmp_luasnip", after = "nvim-cmp", requires = "L3MON4D3/LuaSnip"},
      },
      config = [[require("config.cmp")]]
    }

    -- Motion
    use {
      "ggandor/lightspeed.nvim",
      event = "BufAdd"
    }

    -- Aesthetics
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufAdd",
      config = function()
        require("indent_blankline").setup({
          show_current_context = true
        })
      end
    }
    use {
      "nvim-tree/nvim-web-devicons",
    }
    use {
      "folke/lsp-colors.nvim",
      after = "nvim-lspconfig"
    }
    use {
      "nvim-lualine/lualine.nvim",
      after = {"nvim-web-devicons", "github-nvim-theme"},
      config = [[require("config.lualine")]]
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufAdd",
      requires = {"nvim-lua/plenary.nvim"},
      config = [[require("config.gitsigns")]]
    }
    use {
      "NvChad/nvim-colorizer.lua",
      event = "BufAdd",
      config = function()
        require("colorizer").setup({
          filetypes = {
            "*", -- highlight all filetypes
            "!vim", -- but exclude vim
            "!lua", -- and exclude lua
            css = {rgb_fn = true}
          },
          user_default_options = {
            RRGGBBAA = true
          }
        })
      end
    }
    use {
      "projekt0n/github-nvim-theme",
      config = function()
        require("github-theme").setup({
          options = {
            transparent = true,
            hide_nc_statusline = false
          }
        })
        vim.cmd("colorscheme github_dark")
      end
    }

    -- Misc
    use {
      "ellisonleao/glow.nvim",
      event = "VimEnter",
      config = function()
        require("glow").setup({
          install_path = vim.env.HOME .. "/bin",
          border = "single",
          pager = true
        })
      end
    }
    use {
      "mickael-menu/zk-nvim",
      after = "nvim-lspconfig",
      config = [[require("config.zknvim")]]
    }

    -- Language support
    use {
      "simrat39/rust-tools.nvim",
      after = "nvim-lspconfig",
      event = "BufAdd",
      config = [[require("config.rust-tools")]]
    }
    use {
      "TovarishFin/vim-solidity",  -- smart contract dev
      event = "BufAdd",
    }
    use {
      "prisma/vim-prisma",
      event = "BufAdd"
    }
  end
)
