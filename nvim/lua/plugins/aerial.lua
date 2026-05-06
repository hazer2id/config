return {
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        filter_kind = false,
        attach_mode = "global",
        show_guides = true,
        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
        keymaps = {
          ["t"] = "actions.next",
          ["e"] = "actions.prev",
          ["<Space>"] = "actions.jump",
          ["r"] = "actions.tree_toggle",
          ["j"] = false,
          ["k"] = false,
          ["<CR>"] = false,
          ["o"] = false,
          ["za"] = false,
        },
      })
      require("telescope").load_extension("aerial")
    end,
  },
}
