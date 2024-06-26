return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup {}
    vim.keymap.set('n', "<S-h>", "<cmd>BufferLineCyclePrev<cr>")
    vim.keymap.set('n', "<S-l>", "<cmd>BufferLineCycleNext<cr>")
    vim.keymap.set('n', "<leader>bo", "<cmd>BufferLineCloseOthers<cr>")
    vim.keymap.set('n', "<leader>bd", "<cmd>bd<cr>")
  end
}
