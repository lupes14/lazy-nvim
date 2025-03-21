-- lua/config/git-signs.lua
local M = {}

function M.setup()
  -- Highlight Groups
  vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitGutterAdd' })
  vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitGutterChange' })
  vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitGutterDelete' })
  vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitGutterDelete' })
  vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitGutterChangeDelete' })

  require('gitsigns').setup {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '│' },
      topdelete    = { text = '‾' },
      changedelete = { text = '│' },
    },
    preview_config = {
      border = 'rounded',
    },
    on_attach = function(bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gh', '<cmd>Gitsigns diffthis<CR>', { noremap = true })
    end
  }
end

return M
