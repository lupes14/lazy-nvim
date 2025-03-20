-- lua/config/snack.lua
---@type snacks.Config
local M = {}

M.opts = {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      { section = "startup"},
    },
  },
  explorer = { enabled = true },
  indent = {
    enabled = true,
    only_scope = true,
    only_current = true,
    animate = { enabled = false },
    scope = { enabled = false },
    chunk = { enabled = true, only_current = true, hl = "SnacksIndentColor" }
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    style = "fancy",
  },
  notify = { enabled = true },
  picker = {
    enabled = false,
    layout = "ivy",
    position = "bottom",
    sources = {
      files = { hidden = true },
      explorer = { hidden = true },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  terminal = { enabled = false },
  toggle = { enabled = true, which_key = true },
  words = { enabled = true },
  styles = {
    notification = {
      -- wo = { wrap = true } -- Wrap notifications
    }
  },
}

M.keys = {
-- Key mappings are in nvim/lua/config/vim/keymaps.lua
}

M.init = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      -- Setup some globals for debugging (lazy-loaded)
      _G.dd = function(...) Snacks.debug.inspect(...) end
      _G.bt = function() Snacks.debug.backtrace() end
      vim.print = _G.dd -- Override print to use snacks for `:=` command
    end,
  })
end

return M
