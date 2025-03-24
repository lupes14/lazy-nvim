-- lua/config/vim/settings.lua
-- Set Cursor
vim.o.guicursor = ''

-- Set color scheme
vim.cmd('colorscheme night-owl')

vim.cmd [[
  highlight Normal ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight LineNr ctermbg=NONE guibg=NONE
  highlight nonText ctermbg=NONE guibg=NONE
  highlight EndOfBuffer ctermbg=NONE guibg=NONE
  highlight Search ctermfg=black ctermbg=111
  highlight IncSearch ctermfg=black ctermbg=176
  highlight SnacksIndentColor guifg=#d7afff ctermfg=183
]]

-- Line settings
vim.o.number = true
vim.o.relativenumber = true
vim.cmd('highlight LineNr ctermfg=Grey guifg=Grey')

-- Mode settings
vim.o.showmode = false

-- Tab settings
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.shiftwidth = 2   -- Indentation width
vim.o.tabstop = 2      -- Number of spaces a tab character represents
vim.o.softtabstop = 2  -- How many spaces to insert when pressing Tab

-- Scroll settings
vim.o.scrolloff = 8

-- How fast Cursor/Buffer udpates in milliseconds
vim.o.updatetime = 50

-- Set floating terminal settings
vim.g.floaterm_title = ' Terminal ($1/$2) '

-- Enable hidden buffers
vim.o.hidden = true

-- Diable LSP logging, set to debug if need to debug issues
vim.lsp.set_log_level('off')
