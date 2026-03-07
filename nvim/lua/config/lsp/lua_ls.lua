return {
  cmd = { 'lua-language-server' },
  root_markers = {'.luarc.json', '.luarc.jsonc'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostios = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    }
  }

}
