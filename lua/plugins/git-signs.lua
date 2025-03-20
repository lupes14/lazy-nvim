-- lua/plugins/git-signs.lua
return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require("config.git-signs").setup()
    end
}
