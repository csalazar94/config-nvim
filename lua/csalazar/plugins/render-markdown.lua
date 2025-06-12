return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'copilot-chat' },
    checkbox = {
      unchecked = {
        icon = '󰄱 ',
        highlight = 'RenderMarkdownUnchecked',
        scope_highlight = nil,
      },
      checked = {
        icon = '󰱒 ',
        highlight = 'RenderMarkdownChecked',
      },
      custom = {
        todo = {
          raw = '[>]',
          rendered = '󰥔 ',
          highlight = 'RenderMarkdownTodo',
        },
        canceled = {
          raw = '[~]',
          rendered = '󰰱 ',
          highlight = 'DiagnosticError',
        },
        important = {
          raw = '[!]',
          rendered = ' ',
          highlight = 'DiagnosticWarn',
        },
      },
    },
  },
}
