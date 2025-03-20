-- lua/config/tree-sitter.lua
local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "python", "javascript", "bash", "html", "css", "terraform" },
    sync_install = false,
    auto_install = true,
    highlight = {
      ignore_install = { "gitcommit", "gitrebase" },
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end

return M
