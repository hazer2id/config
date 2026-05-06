return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-file-browser.nvim",
		},
    config = function()
      local fb_actions = require("telescope._extensions.file_browser.actions")
      require("telescope").setup{
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = "close",
            },
            n = {
              ["t"] = "move_selection_next",
              ["e"] = "move_selection_previous",
              ["r"] = "select_default",
              ["/"] = function()
                vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("i", true, false, true),
                  "n",
                  false
                )
              end,
            },
          },
          prompt_prefix = "/ ",
          path_display = {
            filename_first = {
                reverse_directories = true
            }
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            initial_mode = "normal",
            grouped = true,
            hide_parent_dir = true,
            sorting_strategy = "ascending",
            mappings = {
              n = {
                ["<space>"] = fb_actions.goto_parent_dir,
                ["."] = fb_actions.toggle_hidden,
                ["c"] = fb_actions.create,
                ["n"] = fb_actions.rename,
              }
            }
          },
        },
      }

      require("telescope").load_extension("file_browser")

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function ()
          if vim.fn.argc() == 0 and vim.bo.buftype == "" then
            vim.schedule(function()
              require("telescope").extensions.file_browser.file_browser()
            end)
          end
        end
      })
    end,
  }
}
