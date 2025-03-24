-- lua/config/snacks.lua

----------------------------------------------------------------
-- Locals
----------------------------------------------------------------
-- Disabled features
local disabled_features = {
  'scroll', 'terminal'
}

-- Features with default configurations
local enabled_features_w_default_configs = {
  'input', 'bigfile', 'notify', 'quickfile', 'scope', 'statuscolumn', 'styles', 'words'
}

-- Pickers with custom configurations
local pickers_w_custom_configs = {
  'explorer', 'files', 'projects', 'recent', 'git_branches', 'git_log', 'git_files',
  'git_status', 'git_stash', 'git_diff', 'git_log_file', 'lines', 'grep', 'grep_buffers',
  'buffers', 'registers', 'notifications', 'autocmds', 'commands', 'keymaps', 'undo',
  'diagnostics_buffer', 'colorschemes', 'command_history', 'search_history'
}


----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
-- Toggle feature enable/disable
local function feature_subfeature_toggle(toggle)
  return { enabled = toggle }
end

-- Generate greeting based on time of day
local function get_greeting()
  local hour = tonumber(vim.fn.strftime('%H'))
  local part_id = math.floor((hour + 6) / 8) + 1
  local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]

  return {
    align = 'center',
    text = { ('“Good %s, Camden”'):format(day_part), hl = 'NonText' },
    padding = 1
  }
end

-- Picker layout configuration
local function picker_layout(preview)
  return {
    preset = 'vscode',
    preview = preview,
    layout = {
      border = 'rounded',
      width = 0.5,
      height = 0.4,
      box = 'vertical',
    },
  }
end


----------------------------------------------------------------
-- Snacks Module
----------------------------------------------------------------
local M = {}
M.info = {}

M.opts = {
  -- Dashboard Configuration
  dashboard = {
    enabled = true,
    preset = {},
    formats = {
      key = function(item)
        return { { '[', hl = 'NonText' }, { item.key, hl = '@string' }, { ']', hl = 'NonText' } }
      end,
    },
    sections = {
      {
        align = 'center',
        padding = 1,
        text = {
          { [[
  _  _     ___     ___   __   __   ___   __  __  
 | \| |   | __|   / _ \  \ \ / /  |_ _| |  \/  | 
 | .` |   | _|   | (_) |  \ V /    | |  | |\/| | 
 |_|\_|   |___|   \___/   _\_/_   |___| |_|__|_| 
_|'''''|_|'''''|_|'''''|_| ''''|_|'''''|_|'''''| 
'`-0-0-''`-0-0-''`-0-0-''`-0-0-''`-0-0-''`-0-0-' 
          ]] , hl = 'Label' },
        },
      },
      get_greeting,
      { icon = ' ', key = 'f', desc = 'Find Files', action = ':lua Snacks.dashboard.pick("files")' },
      { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.picker.recent()' },
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = '󰒲 ', key = 'l', desc = 'Open Lazy', action = ':Lazy' },
      { icon = '󱎸 ', key = 'm', desc = 'Open Mason', action = ':Mason' },
      { icon = '󰍃 ', key = 'q', desc = 'Quit', action = ':q', padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1, limit = 10 },
      { section = 'startup', padding = 1 },
      function()
        local version = M.info.nvim_version()
        local plugin_stats = M.info.plugin_stats()
        local updates = plugin_stats.updates > 0 and '  ' .. plugin_stats.updates .. '' or ''
        local date = os.date('%m.%d.%Y')
        return {
          align = 'center',
          text = {
            { ' ' .. version, hl = 'Label' },
            { ' | ', hl = 'NonText' },
            { ' ' .. tostring(plugin_stats.count), hl = 'Label' },
            { updates, hl = '@string' },
            { ' | ', hl = 'NonText' },
            { '󰃭 ' .. date , hl = 'Label' },
          },
          padding = 1,
        }
      end,
    },
  },
  -- Indentation Configuration
  indent = {
    enabled = true,
    only_scope = true,
    only_current = true,
    animate = feature_subfeature_toggle(false),
    scope = feature_subfeature_toggle(false),
    chunk = { enabled = true, only_current = true, hl = 'SnacksIndentColor' }
  },
  -- Notifications
  notifier = {
    enabled = true,
    style = 'fancy',
  },
  -- Picker Configuration
  picker = {
    enabled = true,
    sources = {},
  },
}

M.opts.toggle = {
  enabled = true,
  which_key = true
}


----------------------------------------------------------------
-- Module Configurations
----------------------------------------------------------------
M.init = function()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      -- Setup some globals for debugging (lazy-loaded)
      _G.dd = function(...) Snacks.debug.inspect(...) end
      _G.bt = function() Snacks.debug.backtrace() end
      vim.print = _G.dd -- Override print to use snacks for `:=` command
    end,
  })
end


----------------------------------------------------------------
-- Module Configurations
----------------------------------------------------------------
-- Configure disabled features
for _, feature in ipairs(disabled_features) do
  M.opts[feature] = { enabled = false }
end

-- Configure enabled features with default configs
for _, feature in ipairs(enabled_features_w_default_configs) do
  M.opts[feature] = { enabled = true }
end

-- Configure pickers with custom settings
for _, feature in ipairs(pickers_w_custom_configs) do
  local preview_value = not (feature == 'command_history' or feature == 'search_history' or feature == 'files' or feature == 'recent')

  if not vim.tbl_contains(disabled_features, feature) then
    M.opts.picker.sources[feature] = {
      layout  = picker_layout(preview_value),
      hidden  = feature == 'files' or feature == 'grep' or feature == 'explorer' or feature == 'git_files' or feature == 'recent',
      ignored = feature == 'explorer',
    }
  end
end


----------------------------------------------------------------
-- Module Specific Functions
----------------------------------------------------------------
---@return string
function M.info.nvim_version()
  local version = vim.version()
  return ('v%d.%d.%d'):format(version.major, version.minor, version.patch)
end

---@return table
function M.info.plugin_stats()
  local stats = require('lazy').stats()
  local updates = require('lazy.manage.checker').updated
  return {
    count = stats.count,
    loaded = stats.loaded,
    startuptime = (math.floor(stats.startuptime * 100 + 0.5) / 100),
    updates = #updates,
  }
end


----------------------------------------------------------------
-- Return Module
----------------------------------------------------------------
return M
