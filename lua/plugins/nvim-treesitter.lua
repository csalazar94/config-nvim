return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "vue" })
      vim.list_extend(opts.ensure_installed, { "prisma" })
    end
  end,
}
