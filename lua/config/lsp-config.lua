-- lua/config/lsp-config.lua
local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Automatically set up LSP servers that Mason installs
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      -- Configure Mason Installed LSP Servers
      lspconfig[server_name].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'},
            },
          },
        },
      })
    end,
  })
end

return M
