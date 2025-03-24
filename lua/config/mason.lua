-- lua/config/mason.lua
local M = {}

function M.setup()
  local lsp_servers = { 'vimls', 'lua_ls', 'bashls', 'pyright', 'terraformls' }

  require('mason').setup({
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗'
      }
    }
  })

  return lsp_servers
end

return M
