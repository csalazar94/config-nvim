return {
  'mistweaverco/kulala.nvim',
  ft = "http",
  keys = {
    { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>" },
    { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>" },
    { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>" },
    { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>" },
  },
  opts = {}
}
