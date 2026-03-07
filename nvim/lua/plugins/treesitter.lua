local lsp = require("config.lsp.common")

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local languages = {}
      for _, l in pairs(lsp.languages) do
        vim.list_extend(languages, l)
      end
      require('nvim-treesitter').install(languages)
    end,
  },
}
