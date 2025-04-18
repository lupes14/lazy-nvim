-- lua/config/cmp.lua
local M = {}

function M.setup()
  local cmp = require'cmp'
  local luasnip = require'luasnip'

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Up>'] = cmp.mapping(function() end, { 'i', 'c' }),
      ['<Down>'] = cmp.mapping(function() end, { 'i', 'c' }),
      ['<Left>'] = cmp.mapping(function() end, { 'i', 'c' }),
      ['<Right>'] = cmp.mapping(function() end, { 'i', 'c' }),
    }),

    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
    },

    window = {
      completion = {
        border = "rounded",
        scrollbar = false,
        winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:PmenuSel",
      },
      documentation = {
        border = "rounded",
        scrollbar = false,
        winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder",
      },
    },

    experimental = {
      ghost_text = false,
    },
  })

  -- Use buffer source for '/' and '?'
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end

return M
