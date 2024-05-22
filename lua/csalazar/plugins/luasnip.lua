return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        local ls = require("luasnip")
        local extras = require("luasnip.extras")
        local fmt = require("luasnip.extras.fmt").fmt
        local s = ls.snippet
        local i = ls.insert_node
        local rep = extras.rep

        ls.add_snippets("javascript", {
          s("lo", fmt(
            [[
            console.log('{}', JSON.stringify({}, null, 2));
            ]], {
              i(1), rep(1)
            }))
        })
      end,
    },
  },
}
