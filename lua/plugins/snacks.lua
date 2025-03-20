-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = require("config.snacks").opts,
  keys = require("config.snacks").keys,
  init = require("config.snacks").init,
}
