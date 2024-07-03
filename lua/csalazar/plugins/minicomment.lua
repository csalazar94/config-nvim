return {
  "echasnovski/mini.comment",
  opts = {
    custom_commentstring = function()
      return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
    end,
  },
  config = true
}
