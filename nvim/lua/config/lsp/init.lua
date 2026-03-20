local common = require("config.lsp.common")

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = {".git"},
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })
    end
  end,
})

for s, l in pairs(common.languages) do
  local c = require("config.lsp." .. s)
  c.filetypes = l
  vim.lsp.config(s, c)
  vim.lsp.enable(s)
end
