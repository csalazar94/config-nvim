return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("neodev").setup({})
    require("mason").setup({})

    local lspconfig = require('lspconfig')

    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    local flags = {
      allow_incremental_sync = false,
      debounce_text_changes = 1000,
    }

    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "lua_ls", "gopls", "pyright",
        "astro", "bashls", "ts_ls",
        "cmake", "cssls", "dockerls", "eslint", "html",
        "jsonls", "prismals", "tailwindcss",
        -- "volar", "djlint"
      },
      handlers = {
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            flags = flags,
          }
        end,
        tsserver = function()
          -- disable tsserver
          return true
        end,
        eslint = function()
          lspconfig.eslint.setup {
            capabilities = capabilities,
            flags = flags,
          }
        end,
        gopls = function()
          lspconfig.gopls.setup {
            capabilities = capabilities,
            flags = flags,
            settings = {
              gopls = {
                hints = {
                  rangeVariableTypes = true,
                  parameterNames = true,
                  constantValues = true,
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  functionTypeParameters = true,
                },
              },
            },
          }
        end,
        volar = function()
          lspconfig.volar.setup {
            capabilities = capabilities,
            flags = flags,
            init_options = {
              vue = {
                hybridMode = true,
              },
            },
            filetypes = { "vue" },
          }
        end,
        ts_ls = function()
          local jstsconfig = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          }

          lspconfig.ts_ls.setup {
            capabilities = capabilities,
            flags = flags,
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fn.stdpath 'data' ..
                      '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                  languages = { "vue" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
            settings = {
              javascript = jstsconfig,
              typescript = jstsconfig,
            },
          }
        end,
      },
    })

    vim.diagnostic.config({
      virtual_text = {
        source = true,
      },
      float = {
        source = true,
      },
    })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
    vim.keymap.set('n', '<leader>sl', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(args)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = args.buf, desc = desc })
        end

        map(
          '<leader>i',
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
          end,
          'Toggle inlay hints'
        )

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
