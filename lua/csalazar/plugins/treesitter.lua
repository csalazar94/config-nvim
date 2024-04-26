return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { 
        "vimdoc", "javascript", "typescript", "lua", "rust",
        "jsdoc", "bash", "markdown", "markdown_inline", "html",
        "json", "jsonc", "python", "tsx", "astro", "css", "go",
        "gomod", "gowork", "gosum", "toml", "prisma",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      indent = {
        enable = true
      },

      highlight = {
        enable = true,
      },
    }
  end
}
