local lsp = require("config.lsp.common")

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ft_to_parser = {
        sh = "bash",
        zsh = "bash",
        jsonc = "json",
        javascriptreact = "javascript",
        typescriptreact = "tsx",
      }
      local skip = { less = true }
      local seen = {}
      local languages = {}
      for _, langs in pairs(lsp.languages) do
        for _, l in ipairs(langs) do
          if not skip[l] then
            local parser = ft_to_parser[l] or l
            if not seen[parser] then
              seen[parser] = true
              table.insert(languages, parser)
            end
          end
        end
      end
      require('nvim-treesitter').install(languages)
    end,
  },
}
