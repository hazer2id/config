local E = {}

E.languages = {
  lua_ls = {"lua"},
  clangd = {"c", "cpp"},
}

function E.get_languages()
  local languages = {}
  for _, l in pairs(E.languages) do
    vim.list_extend(languages, l)
  end
  return languages
end

function E.completion_next(key)
  if vim.fn.pumvisible() == 1 then
    vim.api.nvim_feedkeys(vim.keycode("<c-n>"), "n", false)
  else
    vim.api.nvim_feedkeys(vim.keycode(key), "n", false)
  end
end

function E.completion_confirm(key)
  if vim.fn.pumvisible() == 1 then
    vim.api.nvim_feedkeys(vim.keycode("<c-y>"), "n", false)
  else
    vim.api.nvim_feedkeys(vim.keycode(key), "n", false)
  end
end

return E
