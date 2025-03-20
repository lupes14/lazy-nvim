-- lua/plugins/tcomment.lua
return {
    'tomtom/tcomment_vim',
    lazy = true,  -- Enable lazy loading
    keys = {      -- Load on these key mappings
        { 'gc', mode = { 'n', 'v' } },
    },
}
