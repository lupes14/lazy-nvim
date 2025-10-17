-- lua/config/lualine.lua
local M = {}

local function trailing_spaces()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and '⚠ TW:'..space or ''
end

local function mixed_indent()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]

  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line

  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end

  if not mixed then return '' end

  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return '⚠ MI:'..mixed_same_line
  end

  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt = vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total

  if space_indent_cnt > tab_indent_cnt then
    return '⚠ MI:'..tab_indent
  else
    return '⚠ MI:'..space_indent
  end
end

function M.setup()
  -- Night Owl colors
  local colors = {
    bg        = '#121212',
    fg        = '#d6deeb',
    cyan      = '#7fdbca',
    grey      = '#2a2a2a',
    green     = '#22da6e',
    tan       = '#d7af87',
    violet    = '#d7afff',
    magenta   = '#ff5370',
    blue      = '#82aaff',
    red       = '#f07178',
  }

  require('lualine').setup {
    options = {
      theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.violet, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.grey },
          c = { fg = colors.fg, bg = colors.bg },
        },
        insert = {
          a = { fg = colors.bg, bg = colors.tan, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.grey },
          c = { fg = colors.fg, bg = colors.bg },
        },
        visual = {
          a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.grey },
          c = { fg = colors.fg, bg = colors.bg },
        },
        replace = {
          a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.grey  },
          c = { fg = colors.fg, bg = colors.bg },
        },
        command = {
          a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.grey },
          c = { fg = colors.fg, bg = colors.bg },
        },
        inactive = {
          a = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
        },
      },
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        'filename',
        { trailing_spaces, color = { fg = colors.tan } },
        { mixed_indent, color = { fg = colors.tan } },
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {
        function()
          return string.format('Ln:%d, Col:%d', vim.fn.line('.'), vim.fn.col('.'))
        end
      },
    },
  }
end

return M
