-- lua/config/lualine.lua
local M = {}

local function trailing_spaces()
  local space = vim.fn.search([[\s\+$]], 'nwc')  -- Search for trailing whitespace
  return space ~= 0 and '⚠ TW:'..space or ''     -- Return 'TW:count' if spaces are found, else empty
end

local function mixed_indent()
  local space_pat = [[\v^ +]]   -- Pattern to match lines starting with spaces
  local tab_pat = [[\v^\t+]]    -- Pattern to match lines starting with tabs

   -- Search for the first occurrence of spaces and tabs at the start of a line
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  -- Check if mixed indentation is present within the file
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line

  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end

  if not mixed then return '' end

  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return '⚠ MI:'..mixed_same_line                       -- Show mixed indentation on the same line
  end
  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt = vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
  if space_indent_cnt > tab_indent_cnt then
    return '⚠ MI:'..tab_indent              -- Return tab indentation if there are more spaces
  else
    return '⚠ MI:'..space_indent            -- Return space indentation if there are more tabs
  end
end

function M.setup()
  require('lualine').setup {
    options = {
      theme = 'auto',
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
    },
    sections = {
      lualine_b = {
        'branch',
        'diff',
        'diagnostics',
      },
      lualine_c = {
        'filename',
        { trailing_spaces, color = { fg = '#ffaa88' } },
        { mixed_indent, color = { fg = '#ffaa88'} },
      },
      lualine_x = {
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = {
        'progress',
      },
      lualine_z = {
          function()
            return string.format('Ln:%d, Col:%d', vim.fn.line('.'), vim.fn.col('.'))
          end
      },
    },
  }
end

return M
