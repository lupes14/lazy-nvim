-- lua/config/floaterm.lua
---@type table
local M = {}

M.config = function()
  vim.g.floaterm_width = 0.99         -- Set width (99% of screen)
  vim.g.floaterm_height = 0.40        -- Set height (40% of screen)
  vim.g.floaterm_wintype = "float"
  vim.g.floaterm_position = "bottom"
  vim.g.floaterm_border = "rounded"
end

return M
