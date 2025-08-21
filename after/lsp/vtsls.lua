local jstsconfig = {
  updateImportsOnFileMove = { enabled = "always" },
  suggest = {
    completeFunctionCalls = true,
  },
  inlayHints = {
    enumMemberValues = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    parameterNames = { enabled = "literals" },
    parameterTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    variableTypes = { enabled = false },
  },
}

return {
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = {
          {
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
            languages = { "vue" },
            location = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            name = "@vue/typescript-plugin",
          }
        },
      },
    },
    javascript = jstsconfig,
    typescript = jstsconfig,
  },
}
