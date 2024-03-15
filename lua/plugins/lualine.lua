return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections.lualine_y = { "progress" }
    opts.sections.lualine_z = { "location" }
  end,
}
