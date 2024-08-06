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
      theme = "doom",
      shuffle_letter = false,
      config = {
        header = vim.split(logo, "\n"),
        center = {
          { icon = '󰚰 ',
            desc = 'Sync',
            group = '@property',
            action = 'Lazy sync',
            key = 's',
          },
          {
            icon = '󱋢 ',
            desc = 'Recent Files',
            group = '@variable',
            action = 'Telescope oldfiles cwd_only=true',
            key = 'r',
          },
          {
            icon = '󰱽 ',
            desc = 'Files',
            group = '@variable',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = '󰙅 ',
            desc = 'Neotree',
            group = '@variable',
            action = function() vim.cmd("Neotree toggle") end,
            key = 'e',
          },
          {
            icon = '󰿅 ',
            desc = 'Quit',
            group = 'Label',
            action = function() vim.api.nvim_input("<cmd>qa<cr>") end,
            key = 'q',
          },
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
