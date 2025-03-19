return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local actions = require("telescope.actions")
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<S-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["<S-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sF', builtin.git_files, { desc = 'Find git files' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Find in buffer' })
    vim.keymap.set('n', '<leader>sw', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end, { desc = 'Search word' })
    vim.keymap.set('n', '<leader>sW', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end, { desc = 'Search WORD' })
  end
}
