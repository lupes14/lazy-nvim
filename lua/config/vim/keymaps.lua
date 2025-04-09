-- lua/config/vim/keymaps.lua
local wk = require('which-key')
local dap = require("dap")
local dapui = require("dapui")

wk.add({
  -- Disable keys
  { 'Q', '<nop>', mode = 'n' },
  { '<Up>', '<nop>', mode = 'n' },
  { '<Down>', '<nop>', mode = 'n' },
  { '<Left>', '<nop>', mode = 'n' },
  { '<Right>', '<nop>', mode = 'n' },
  -- Navigation improvements
  { '<C-u>', '<C-u>zz', mode = 'n', desc = 'Scroll down half a page and focus buffer' },
  { '<C-d>', '<C-d>zz', mode = 'n', desc = 'Scroll up hald a page and focus buffer' },
  { 'n', 'nzzzv', mode = 'n', desc = 'Skip forward a search result and focus buffer' },
  { 'N', 'Nzzzv', mode = 'n', desc = 'Skip back a search result and focus buffer' },
  { 'J', 'mzJz', mode = 'n', desc = 'Pull line below up to current line' },
  -- Move lines in visual mode
  { 'K', ":m '<-2<CR>gv=gv", mode = 'v' },
  { 'J', ":m '>+1<CR>gv=gv", mode = 'v' },
  -- Terminal (Floaterm)
  { '<C-M-\\>', ':FloatermNew<CR>', mode = 'n' },
  { '<C-M-_>', ':FloatermToggle<CR>', mode = 'n' },
  { '<C-M-\\>', '<C-\\><C-n>:FloatermNew<CR>', mode = 't' },
  { '<C-M-_>', '<C-\\><C-n>:FloatermToggle<CR>', mode = 't' },
  { '<C-M-h>', '<C-\\><C-n>:FloatermNext<CR>', mode = 't' },
  { '<C-M-l>', '<C-\\><C-n>:FloatermPrev<CR>', mode = 't' },
  { '<C-M-k>', '<C-\\><C-n>:FloatermKill!<CR>', mode = 't' },
  { '<Esc>', '<C-\\><C-n>', mode = 't' },
  -- Reference Navigation
  { ']]',         function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
  { '[[',         function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
  -- Base Leader Key maps
  { '<leader>\'', function() Snacks.scratch() end, desc = 'Scratch Buffer', icon = { icon = '', color = 'yellow', hl = 'None' }  },
  { '<leader>"', function() Snacks.scratch.select() end, desc = 'Scrach Buffer History', icon = { icon = '', color = 'green', hl = 'None' }  },
  { '<leader>,', function() Snacks.picker.registers() end, desc = 'Registers/Clipboard', icon = { icon = '', color = 'green', hl = 'None' }  },
  { '<leader>.', function() Snacks.picker.buffers() end, desc = 'Buffer History', icon = { icon = '', color = 'green', hl = 'None' }  },
  { '<leader>?', function() Snacks.picker.notifications() end, desc = 'Notification History', icon = { icon = '', color = 'green', hl = 'None' } },
  { '<leader>/', function() Snacks.picker.search_history() end, desc = 'Search History' },
  { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History', icon = { icon = '', color = 'green', hl = 'None' } },
  { '<leader><leader>', function() Snacks.picker.resume() end, desc = 'Last Open Picker', icon = { icon = '󰼨', color = 'yellow', hl = 'None' } },
  { '<leader>z', function() Snacks.zen.zoom() end, desc = 'Zoom', icon = { icon = '', color = 'yellow', hl = 'None' } },
  -- Buffers
  { '<leader>b', group = 'Buffers', mode = {'n', 'v'}, icon = { icon = '', color = 'green', hl = 'None' } },
  { '<leader>bc', ':tabnew<CR>', mode = {'n', 'v'}, desc = 'Create a new Empty Buffer as a tab', icon = { icon = '󰓩', color = 'yellow', hl = 'None' } },
  { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Current Buffer', icon = { icon = '󰇾', color = 'grey', hl = 'None' }  },
  { '<leader>bn', ':tabnext<CR>', mode = {'n', 'v'}, desc = 'Switch to Next Buffer tab', icon = { icon = '󰓩', color = 'yellow', hl = 'None' } },
  { '<leader>bp', ':tabprevious<CR>', mode = {'n', 'v'}, desc = 'Switch to Previous Buffer Tab', icon = { icon = '󰓩', color = 'yellow', hl = 'None' } },
  { '<leader>t', group = 'Tabs', icon = { icon = '󰓩', color = 'yellow', hl = 'None' } },
  -- Debuggers
  { '<leader>d', group = 'Debuggers', mode = {'n'}, icon = { icon = '', color = 'red', hl = 'None' } },
  { '<leader>db', function() dap.toggle_breakpoint() end, desc = 'Add breakpoint', icon = { icon = '', color = 'red', hl = 'None' } },
  { '<leader>dc', function() dap.continue() end, desc = 'Continue', icon = { icon = '', color = 'red', hl = 'None' } },
  { '<leader>di', function() dap.step_into() end, desc = 'Step Into', icon = { icon = '', color = 'red', hl = 'None' } },
  { '<leader>do', function() dap.step_out() end, desc = 'Step Out', icon = { icon = '', color = 'red', hl = 'None' } },
  { '<leader>dO', function() dap.step_over() end, desc = 'Step Over', icon = { icon = '', color = 'red', hl = 'None' } },
  { '<leader>dq', function() dap.terminate() end, desc = 'Quit Debugger', icon = { icon = '', color = 'red', hl = 'None' } },
  { '<leader>du', function() dapui.toggle() end, desc = 'Toggle DAP UI', icon = { icon = '', color = 'red', hl = 'None' } },
  -- Diagnostics
  { '<leader>D', group = 'Diagnostics', icon = { icon = '', color = 'yellow', hl = 'None' } },
  { '<leader>Df', function() Snacks.picker.diagnostics_buffer() end, desc = 'Find Buffer Diagnostics', icon = { icon = '', color = 'yellow', hl = 'None' } },
  {
    '<leader>Dd',
    function()
      local diagnostics = vim.diagnostic.get(0)
      if #diagnostics > 0 then
        vim.diagnostic.open_float(nil, {
          focusable = true,
          border = 'rounded',
          severity_sort = true,
        })
      else
        vim.notify("No diagnostics to show.", vim.log.levels.INFO)
      end
    end,
    desc = 'Show Diagnostic (styled + interactive)',
    icon = { icon = '', color = 'yellow', hl = 'None' }
  },
  -- Telescope
  { '<leader>f', group = 'Telescope', icon = { icon = '', color = 'green', hl = 'None' }},
  { '<leader>fe', function() Snacks.explorer({ title = ' File Explorer | ' }) end, desc = 'File Explorer', icon = { icon = '󰙅', color = 'yellow', hl = 'None' } },
  { '<leader>ff', function() Snacks.picker.files({ title = ' Files in Current Directory | ', cwd = vim.fn.expand('%:p:h') }) end, desc = 'Find Files in Current File Directory' },
  { '<leader>fg', function() Snacks.picker.git_files({ title = ' Files in Git Repository | ' }) end, desc = 'Find Git Files' },
  { '<leader>fl', function() Snacks.picker.files({ title = ' Files where VIM Launched | ' }) end, desc = 'Find Files where VIM Was Launched' },
  { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Find Projects' },
  { '<leader>fr', function() Snacks.picker.recent({ title = ' Recent Files | ' }) end, desc = 'Find Recent Files' },
  { '<leader>fv', function() Snacks.picker.files({ title = ' VIM Config Files | ', cwd = vim.fn.stdpath('config') }) end, desc = 'Find Vim Config Files' },
  -- Git
  { '<leader>g', group = 'Git', mode = {'n', 'v'} },
  { '<leader>gb', function() Snacks.picker.git_branches({ title = '  Git Branches  |  <C-a> - Create New Branch  |  <C-x> - Delete Branch  ', }) end, desc = 'Git Branches' },
  { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
  { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
  { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
  { '<leader>gs', function() Snacks.picker.git_status({ title = '  Git Status  |  <Tab> to Stage Files  ' }) end, desc = 'Git Status' },
  { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
  { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
  { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
  -- Operations
  { '<leader>j', group = 'Operations', mode = {'n', 'v'}, icon = { icon = '󰡢', color = 'grey', hl = 'None' } },
  { '<leader>jy', '"+y', mode = {'n', 'v'}, desc = 'Yank Into Clipboard', icon = { icon = '', color = 'grey', hl = 'None' } },
  { '<leader>jY', '":+Y', mode = {'n', 'v'}, desc = 'Yank Entire Line Into Clipboard', icon = { icon = '', color = 'grey', hl = 'None' } },
  { '<leader>jd', '"_d', mode = {'n', 'v'}, desc = 'Delete to Void', icon = { icon = '󰇾', color = 'grey', hl = 'None' } },
  { '<leader>jp', '"_ddP', mode = {'n', 'v'}, desc = 'Paste Over and Delete Line to Void', icon = { icon = '󰬳', color = 'grey', hl = 'None' } },
  { '<leader>jr', ':%s#\\<<C-r><C-w>\\>#<C-r><C-w>#gI<Left><Left><Left>', mode = 'n', desc = 'Replace Word Under Cursor', icon = { icon = '󰛔', color = 'grey' , hl = 'None' } },
  { '<leader>jR', function() Snacks.rename.rename_file() end, desc = 'Rename File', icon = { icon = '󰈔', color = 'grey', hl = 'None' } },
  -- Package Managers
  { '<leader>p', group = 'Package Managers', mode = {'n', 'v'}, icon = { icon = '', color = 'yellow', hl = 'None' } },
  { '<leader>pm', ':Mason<CR>', desc = 'Mason - LSP Package Manager', icon = { icon = '', color = 'yellow', hl = 'None' } },
  { '<leader>pl', ':Lazy<CR>', desc = 'Lazy - NVIM Package Manager', icon = { icon = '', color = 'yellow', hl = 'None' } },
  -- Search/Grep
  { '<leader>s', group = 'Search/Grep' },
  { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Search through Autocmds' },
  { '<leader>sb', function() Snacks.picker.grep_buffers() end, desc = 'Grep Through Buffers', icon = { icon = '󰈔', color = 'cyan', hl = 'None' } },
  { '<leader>sc', function() Snacks.picker.commands() end, desc = 'Search through VIM Commands' },
  { '<leader>sf', function() Snacks.picker.lines() end, desc = 'Grep Through Lines in File', icon = { icon = '󰈔', color = 'cyan', hl = 'None' } },
  { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep Through System', icon = { icon = '󰈔', color = 'cyan', hl = 'None' } },
  { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Search through Keymaps' },
  { '<leader>su', function() Snacks.picker.undo() end, desc = 'Search through Undo History' },
  -- LSP
  { '<leader>l', group = 'LSP', icon = { icon = '󰙨', color = 'green', hl = 'None' } },
  { '<leader>ld', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
  { '<leader>lD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
  { '<leader>lr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
  { '<leader>li', function() vim.cmd('Inspect') end, desc = 'Inspect Syntax & Extmarks' },
  { '<leader>lI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
  { '<leader>ly', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
  { '<leader>ls', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
  { '<leader>lS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
  -- Toggle Options Group
  { '<leader>t', group = 'Toggle Options' },
  -- These options come from the lazy loaded snacks configurations at the bottom of the file
  -- Misc. Options Group
  { '<leader>w', group = 'Misc. Options', mode = {'n', 'v'}, icon = { icon = '󱍼', color = 'grey', hl = 'None' } },
  { '<leader>wa', function() Snacks.notifier.hide() end, desc = 'Clear Notifications', icon = { icon = '󰇾', color = 'grey', hl = 'None' } },
  { '<leader>wc', ':noh<CR>', mode = {'n', 'v'}, desc = 'Clear Highlighted Search Selection', icon = { icon = '󰇾', color = 'grey', hl = 'None' } },
  { '<leader>wC', function() Snacks.picker.colorschemes() end, desc = 'Preview VIM Colorschemes' },
  { '<leader>wg', function() Snacks.lazygit() end, desc = 'Lazygit' },
  -- Help Documentation
  { '<leader>h', group = 'Documentation', icon = { icon = '', color = 'grey', hl = 'None' } },
  { '<leader>hm', function() Snacks.picker.man() end, desc = 'Man Pages' },
  { '<leader>hv', function() Snacks.picker.help() end, desc = 'VIM Help Pages' },
  -- Neovim News
  {
    '<leader>hn',
    desc = 'Neovim News',
    function()
      Snacks.win({
        file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = 'yes',
          statuscolumn = ' ',
          conceallevel = 3,
        },
        border = 'rounded',
        title = '  Neovim News  ',
        title_pos = 'center',
        footer = '  Press \'q\' to close  ',
        footer_pos = 'center',
      })
    end,
    icon = { icon = '󱀁', color = 'yellow', hl = 'None' }
  }
})

-- Set Toggle Options
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>ts')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>tw')
Snacks.toggle.line_number():map('<leader>tl')
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>tL')
Snacks.toggle.diagnostics():map('<leader>td')
Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>tc')
Snacks.toggle.treesitter():map('<leader>tT')
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>tb')
Snacks.toggle.inlay_hints():map('<leader>th')
Snacks.toggle.indent():map('<leader>tg')
Snacks.toggle.dim():map('<leader>tD')
Snacks.toggle.zen():map('<leader>tZ')
