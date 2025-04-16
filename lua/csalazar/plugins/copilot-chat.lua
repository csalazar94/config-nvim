return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = 'claude-3.7-sonnet',
      prompts = {
        ReviewChanges = {
          prompt = "Review changes",
          system_prompt = "COPILOT_REVIEW",
          context = "git:unstaged",
        },
      },
      highlight_headers = false,
      error_header = '> [!ERROR] Error',
    },
    keys = {
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Open copilot chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Reset copilot chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Open copilot chat prompt actions",
        mode = { "n", "v" }
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false

          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.opt_local.spell = false
            vim.opt_local.completeopt = "menu,preview,noinsert,popup"
          end
        end,
      })

      chat.setup(opts)
    end,
  }
}
