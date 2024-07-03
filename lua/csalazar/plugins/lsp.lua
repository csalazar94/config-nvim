return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("neodev").setup({
      -- add any options here, or leave empty to use the default settings
    })
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          }
        }
      }
    })
    require("mason").setup()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls", "rust_analyzer", "gopls", "pyright",
        "tsserver", "astro", "bashls", "volar",
        "cmake", "cssls", "dockerls", "eslint", "html",
        "htmx", "jsonls", "prismals", "sqls", "tailwindcss",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup {
            capabilities = capabilities
          }
        end,
        ["tsserver"] = function()
          lspconfig["tsserver"].setup {
            capabilities = capabilities,
            init_options = {
              preferences = {
                disableSuggestions = true,
              },
            },
          }
        end,
      }
    })
    vim.diagnostic.config({
      virtual_text = {
        source = "always",
      },
      float = {
        source = "always",
      },
    })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>sl', vim.diagnostic.open_float)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func)
          vim.keymap.set('n', keys, func, { buffer = event.buf })
        end

        map('gd', require('telescope.builtin').lsp_definitions)
        map('gr', require('telescope.builtin').lsp_references)
        map('gI', require('telescope.builtin').lsp_implementations)
        map('<leader>D', require('telescope.builtin').lsp_type_definitions)
        map('<leader>ss', require('telescope.builtin').lsp_document_symbols)
        map('<leader>rn', vim.lsp.buf.rename)
        map('<leader>ca', vim.lsp.buf.code_action)
        map('K', vim.lsp.buf.hover)
        map('gD', vim.lsp.buf.declaration)
      end,
    })
  end
}
