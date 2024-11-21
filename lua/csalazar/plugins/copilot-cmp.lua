return {
  "zbirenbaum/copilot-cmp",
  enabled = vim.g.ai_cmp, -- only enable if wanted
  opts = {},
  config = function(_, opts)
    local copilot_cmp = require("copilot_cmp")
    copilot_cmp.setup(opts)
  end,
}
