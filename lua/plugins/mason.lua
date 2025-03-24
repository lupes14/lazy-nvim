-- lua/plugins/mason.lua
return {
  'williamboman/mason.nvim',
  dependencies = { 'williamboman/mason-lspconfig.nvim' },
  config = function()
    require('config.mason').setup()
  end,
}
