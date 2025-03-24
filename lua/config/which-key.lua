-- lua/config/which-key.lua
local M = {}

function M.setup(opts)
  local wk = require('which-key')
  wk.setup(vim.tbl_deep_extend('force', opts, {
    preset = 'modern',
  }))
end

return M
