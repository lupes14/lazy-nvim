-- lua/config/lsp-config.lua
local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local servers = require("config.mason").setup()

  require("mason-lspconfig").setup({
    ensure_installed = servers,
    handlers = {
      -- Default handler for all servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          settings = server_name == "lua_ls" and {
            Lua = {
              diagnostics = {
                globals = { "vim", "Snacks" },
              },
            },
          } or nil,
        })
      end,
    },
  })
end

return M
