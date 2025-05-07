-- lua/config/lsp-config.lua
local M = {}

function M.setup()
  local servers = require("config.mason").setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      capabilities = capabilities,
      settings = server == "lua_ls" and {
        Lua = {
          diagnostics = {
            globals = { "vim", "Snacks" },
          },
        },
      } or nil,
    })
  end
end

return M
