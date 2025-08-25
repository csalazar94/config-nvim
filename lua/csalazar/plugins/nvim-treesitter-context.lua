return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "LspAttach",
  opts = { mode = "cursor", max_lines = 5 },
  keys = {
    { "<leader>tc", "<cmd>TSContext toggle<cr>", desc = "Toggle Context" },
  },
}
