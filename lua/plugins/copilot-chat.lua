-- lua/plugins/copilot-chat.lua
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make tiktoken",  -- build required binaries
    opts = {
      model = "claude-sonnet-4.5",
      window = {
        layout = 'horizontal', -- Split horizontally
        width = 1.0, -- Full width
        height = 0.3, -- 30% height at bottom
      },
      headers = {
        user = '👤 You',
        assistant = '🤖 Cooper',
        tool = '🔧 Tool',
      },
      keymaps = {
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        close = "<C-c>",
        submit = "<CR>",
      },
    },
  },
}


