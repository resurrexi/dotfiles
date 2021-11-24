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
    use "neovim/nvim-lspconfig"
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
      event = "InsertEnter",
      after = "nvim-treesitter"
    }
    use {
      "b3nj5m1n/kommentary",
      config = function()
        require("kommentary.config").configure_language("default", {
          prefer_single_line_comments = true,
          use_consistent_indentation = true,
          ignore_whitespace = true
        })
      end
    }
    use {
      "luukvbaal/nnn.nvim",
      config = [[require("config.nnn")]]
    }
    use {
      "junegunn/fzf",
      run = "./install --bin" -- install fzf if not exists
    }
    use {
      "ibhagwan/fzf-lua",
      after = "nvim-web-devicons",
      requires = {
        {"vijaymarupudi/nvim-fzf", after = "fzf"},
      },
      config = [[require("config.fzf")]]
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        {"hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig"},
        {"saadparwaiz1/cmp_luasnip", requires = "L3MON4D3/LuaSnip"},
      },
      config = [[require("config.cmp")]]
    }

    -- Aesthetics
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({
          default = true -- globally enable default icons
        })
      end
    }
    use {
      "folke/lsp-colors.nvim",
      after = "nvim-lspconfig"
    }
    use {
      "nvim-lualine/lualine.nvim",
      after = "nvim-web-devicons",
      config = [[require("config.lualine")]]
    }
    use {
      "lewis6991/gitsigns.nvim",
      requires = {"nvim-lua/plenary.nvim"},
      config = [[require("config.gitsigns")]]
    }
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({
          "*", -- highlight all filetypes
          "!vim", -- but exclude vim
          "!lua", -- and exclude lua
          css = {rgb_fn = true}
        }, {
          RRGGBBAA = true
        })
      end
    }
    use {
      "projekt0n/github-nvim-theme",
      -- load after lualine for `hide_inactive_statusline` to work
      after = "lualine.nvim",
      config = function()
        require("github-theme").setup({
          theme_style = "dark",
          transparent = true,
          hide_inactive_statusline = false
        })
      end
    }
  end
)
