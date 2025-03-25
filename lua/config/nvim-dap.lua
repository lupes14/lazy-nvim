-- lua/config/nvim-dap.lua
local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.15 },
        { id = "stacks", size = 0.15 },
        { id = "watches", size = 0.15 },
        { id = "breakpoints", size = 0.15 },
        { id = "repl", size = 0.15 },
      },
      size = 10,
      position = "left",
    },
    {
      elements = {
        { id = "console", size = 0.8 },
      },
      size = 10,
      position = "bottom",
    },
  },
})

-- Show text input from repl within buffer
require("nvim-dap-virtual-text").setup({
  commented = true,
})

-- Configure dap-python with global virtualenv
dap_python.setup("~/.virtualenvs/debugpy/bin/python")

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "", -- or "❌"
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "", -- or "→"
  texthl = "DiagnosticSignWarn",
  linehl = "Visual",
  numhl = "DiagnosticSignWarn",
})

-- Automatically open/close DAP UI on Debug launch
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
