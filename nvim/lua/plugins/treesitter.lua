local lsp = require("config.lsp.common")

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local languages = {}
      for _, langs in pairs(lsp.languages) do
        for _, l in ipairs(langs) do
          table.insert(languages,
            l == "sh" and "bash" or
            l)
        end
      end
      require('nvim-treesitter').install(languages)
    end,
  },
}
