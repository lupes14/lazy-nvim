-- lua/config/snacks.lua
-- Locals
local M = {}

local function feature_subfeature_toggle(toggle)
  return {
    enabled = toggle
  }
end

local function picker_layout(preview)
  return {
    preset = "vscode",
    preview = preview,
    layout = {
      border = "rounded",
      width = 0.5,
      height = 0.4,
      box = "vertical",
    },
  }
end

local disabled_features = {
  "scroll", "terminal"
}

local enabled_features_w_default_configs = {
  "input", "bigfile", "notify", "quickfile", "scope", "statuscolumn", "styles", "words"
}

local pickers_w_custom_configs = {
  "explorer", "files", "projects", "recent", "git_branches", "git_log", "git_files", "git_status", "git_stash", "git_diff", "git_log_file", "lines", "grep", "grep_buffers", "buffers", "registers", "notifications", "autocmds", "commands", "keymaps", "undo", "diagnostics_buffer", "colorschemes", "command_history", "search_history"
}

M.opts = {
  -- Enabled Features with custom configurations
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
  indent = {
    enabled = true,
    only_scope = true,
    only_current = true,
    animate = feature_subfeature_toggle(false),
    scope = feature_subfeature_toggle(false),
    chunk = { enabled = true, only_current = true, hl = "SnacksIndentColor" }
  },
  notifier = {
    enabled = true,
    style = "fancy",
  },
  picker = {
    enabled = true,
    sources = {},
  },
}

M.opts.toggle = {
  enabled = true,
  which_key = true
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


-- Functions
-- Dynamically configure snacks disabled features
for _, feature in ipairs(disabled_features) do
  M.opts[feature] = { enabled = false }
end

-- Dynamically configure snacks enabled features with default configs
for _, feature in ipairs(enabled_features_w_default_configs) do
  M.opts[feature] = { enabled = true }
end

-- Dynamically configure snacks picker feature with custom settings
for _, feature in ipairs(pickers_w_custom_configs) do
  local preview_value
  if feature == "command_history" or feature == "search_history" or feature == "files" or feature == "recent" then
    preview_value = false
  else
    preview_value = true
  end

  if not vim.tbl_contains(disabled_features, feature) then
    M.opts.picker.sources[feature] = {
      layout  = picker_layout(preview_value),
      hidden  = feature == "files" or feature == "grep" or feature == "explorer" or feature == "git_files" or feature == "recent",
      ignored = feature == "explorer",
    }
  end
end

return M
