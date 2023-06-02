local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "s"}),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
    ["<C-y>"] = cmp.config.disable, -- disable this default keymap
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close()
    }),
    ["<CR>"] = cmp.mapping.confirm({select = true})
  },
  sources = {
    {name = "nvim_lsp", max_item_count = 20}, -- tsserver likes to send back everything
    {name = "luasnip"},
    {name = "buffer" }
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]"
      })
    })
  }
})

-- Use buffer source for '/'
cmp.setup.cmdline({ "/", "?" }, {
  sources = {
    {name = "buffer"}
  }
})

-- Use cmdline & path source for ":"
cmp.setup.cmdline(":", {
  sources = {
    {name = "path"},
    {name = "cmdline"}
  }
})
