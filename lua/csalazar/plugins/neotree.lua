return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = { enabled = true },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "copilot-chat" },
      },
    })
    vim.keymap.set('n', "<leader>e", "<cmd>Neotree<cr>")
  end
}
