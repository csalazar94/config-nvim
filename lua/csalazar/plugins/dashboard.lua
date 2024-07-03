local logo = [[
 ██████╗███████╗ █████╗ ██╗      █████╗ ███████╗ █████╗ ██████╗
██╔════╝██╔════╝██╔══██╗██║     ██╔══██╗╚══███╔╝██╔══██╗██╔══██╗
██║     ███████╗███████║██║     ███████║  ███╔╝ ███████║██████╔╝
██║     ╚════██║██╔══██║██║     ██╔══██║ ███╔╝  ██╔══██║██╔══██╗
╚██████╗███████║██║  ██║███████╗██║  ██║███████╗██║  ██║██║  ██║
 ╚═════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
]]

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      shuffle_letter = false,
      config = {
        header = vim.split(logo, "\n"),
        shortcut = {
          { icon = '󰚰 ',
            desc = 'Sync',
            group = '@property',
            action = 'Lazy sync',
            key = 's',
          },
          {
            icon = ' ',
            desc = 'Files',
            group = '@variable',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = '󰿅 ',
            desc = 'Quit',
            group = 'Label',
            action = function() vim.api.nvim_input("<cmd>qa<cr>") end,
            key = 'q',
          },
        },
        project = { enable = false },
        mru = { limit = 10, cwd_only = true },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
