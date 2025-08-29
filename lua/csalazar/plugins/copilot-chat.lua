return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    selection = function(source)
      return select.visual(source) or select.buffer(source)
    end,
    build = "make tiktoken",
    opts = function()
      local user = vim.env.USER or "User"

      return {
        prompts = {
          ReviewChanges = {
            prompt = "Review changes",
            system_prompt = "COPILOT_REVIEW",
            resources = { "gitdiff:unstaged" },
          },
          PullRequest = {
            prompt = [[
Generate a Pull Request title and description from the current branch changes,
following best practices. Format the output as a Markdown code bloc. Include:
• Concise and descriptive title
• Summary of changes
• Motivation for changes
• References to related issues (e.g., "Closes #123") if applicable
• Important notes for reviewers
]],
          },
        },
        highlight_headers = false,
        auto_insert_mode = false,
        headers = {
          user = "##   " .. user .. " ",
          assistant = "##   Copilot ",
        },
      }
    end,
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
            vim.opt_local.completeopt = "menu,popup,noinsert,noselect"
          end
        end,
      })

      chat.setup(opts)
    end,
  }
}
