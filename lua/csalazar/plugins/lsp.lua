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
        "ts_ls", "astro", "bashls", "volar",
        "cmake", "cssls", "dockerls", "eslint", "html",
        "htmx", "jsonls", "prismals", "tailwindcss",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup {
            capabilities = capabilities
          }
        end,
        ["ts_ls"] = function()
          lspconfig["ts_ls"].setup {
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
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
    vim.keymap.set('n', '<leader>sl', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, 'Go to definition')
        map('gr', require('telescope.builtin').lsp_references, 'Go to references')
        map('gI', require('telescope.builtin').lsp_implementations, 'Go to implementations')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Go to type definitions')
        map('<leader>ss', require('telescope.builtin').lsp_document_symbols, 'Search document symbols')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('K', vim.lsp.buf.hover, 'Show hover information')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
      end,
    })
  end
}
