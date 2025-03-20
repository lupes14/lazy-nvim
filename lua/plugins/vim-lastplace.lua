-- lua/plugins/vim-lastplace.lua
return {
    'farmergreg/vim-lastplace',
    lazy = true,
    event = 'BufReadPost',  -- Load when opening a file
}
