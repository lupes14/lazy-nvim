-- lua/plugins/floaterm.lua
return {
  'voldikss/vim-floaterm',
  config = function()
    require("config.floaterm").config()
  end
}
