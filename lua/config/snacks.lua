-- lua/config/snacks.lua

----------------------------------------------------------------
-- Locals
----------------------------------------------------------------
-- Disabled features
local disabled_features = {
  'scroll', 'terminal', 'image'
}

-- Features with default configurations
local enabled_features_w_default_configs = {
  'input', 'bigfile', 'notify', 'quickfile', 'scope', 'styles', 'words'
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
  local day_part
  if hour < 12 then
    day_part = "morning"
  elseif hour < 18 then
    day_part = "afternoon"
  else
    day_part = "evening"
  end

  local function to_title_case(str)
    return (str:gsub("(%a)([%w_']*)", function(first, rest)
      return first:upper() .. rest:lower()
    end))
  end
  local username = vim.loop.os_getenv('USER_ALIAS_NAME') or vim.loop.os_get_passwd()['username'] or 'user'
  username = to_title_case(username)
  return {
    align = 'center',
    text = { ('“Good %s, %s”'):format(day_part, username), hl = 'NonText' },
    padding = 1
  }
end

-- Picker layout configuration
local function picker_layout(preview)
  return {
    preset = 'vscode',
    preview = preview,
    layout = {
      box    = 'vertical',
      height = 0.40,
      row    = 0,
      border = 'rounded',
      { win  = 'input', height = 1, border = 'rounded', title = 'Find {title} {live} {flags}', title_pos = 'center'},
      {
        box = 'horizontal',
        { win = 'list' },
        { win = 'preview', border = 'left', width = 0.6 },
      },
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
  explorer = {
    replace_netrw = true,
  },
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
  -- Notifications Config
  notifier = {
    enabled = true,
    style = 'fancy',
  },
  -- Picker Config
  picker = {
    enabled = true,
    sources = {},
  },
  -- StatusColumn Config
  statuscolumn = {
    enabled = true,
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
  local preview_value = not (feature == 'command_history' or feature == 'search_history')

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
