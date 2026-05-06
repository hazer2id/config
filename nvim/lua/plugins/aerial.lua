return {
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("aerial").setup({
        backends = { "lsp", "treesitter" },
        layout = {
          default_direction = "right",
        },
        attach_mode = "global",
        show_guides = true,
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
