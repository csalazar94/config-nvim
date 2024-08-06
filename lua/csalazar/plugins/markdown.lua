return {
  'plasticboy/vim-markdown',
  branch = 'master',
  require = { 'godlygeek/tabular' },
  config = function()
    vim.opt.conceallevel = 2
  end
}
