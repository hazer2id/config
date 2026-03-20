return {
  cmd = { "vscode-html-language-server", "--stdio" },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
  },
}
