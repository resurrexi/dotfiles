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
      "saadparwaiz1/cmp_luasnip"
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
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
  },
  {
    "mickael-menu/zk-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("config.zknvim")
    end
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
        enable_chat = true,
        workspace_root = {
          use_lsp = true,
          find_root = nil,
          paths = {
            ".bzr",
            ".git",
            ".hg",
            ".svn",
            "_FOSSIL_",
            "package.json",
          }
        }
      })
    end
  },
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      instructions_file = "avante.md",
      -- for example
      provider = "ollama",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 20480,
            },
        },
        ollama = {
          endpoint = "http://constellux-srv:11434",
          model = "deepseek-r1:8b",
        },
      },
      selector = {
        ---@alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        ---@type avante.SelectorProvider
        provider = "fzf_lua",
        provider_opts = {},
        exclude_auto_select = {}, -- List of items to exclude from auto selection
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        enable_token_counting = true, -- Whether to enable token counting. Default to true.
        auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
        -- Examples:
        -- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
        -- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    },
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
