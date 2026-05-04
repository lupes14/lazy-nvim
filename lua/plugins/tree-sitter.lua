-- lua/plugins/tree-sitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require("config.tree-sitter")
    end,
  },
}
