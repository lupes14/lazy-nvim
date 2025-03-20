-- lua/plugins/tree-sitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("config.tree-sitter").setup()
    end,
  }
}
