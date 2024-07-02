return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
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
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,
        ["tsserver"] = function()
          require("lspconfig")["tsserver"].setup {
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

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('csalazar-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('csalazar-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'csalazar-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })
  end
}
