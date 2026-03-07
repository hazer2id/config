return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
    config = function()
      require("telescope").setup{
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = "close",
            },
          },
        }
      }

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function ()
          if vim.fn.argc() == 0 and vim.bo.buftype == "" then
            vim.schedule(function()
              require("telescope.builtin").find_files()
            end)
          end
        end
      })
    end,
  }
}
