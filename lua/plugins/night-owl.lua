-- lua/plugins/night-owl.lua
return {
    'haishanh/night-owl.vim',
    config = function()
        require("config.night-owl").setup()
    end,
}
