-- lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    require("config.which-key").setup(opts)
  end,
}
