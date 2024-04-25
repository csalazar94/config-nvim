return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sf', builtin.git_files, {})
    vim.keymap.set('n', '<leader>sF', builtin.find_files, {})
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>sw', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>sW', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
  end
}
