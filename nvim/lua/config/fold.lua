vim.opt.viewoptions = {"folds"}
vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave", "VimLeavePre"}, {
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd("silent! mkview!")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    if vim.bo.buftype == "" then
      vim.schedule(function()
        vim.schedule(function()
          vim.cmd("silent! loadview")
        end)
      end)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = require("config.lsp.common").get_languages(),
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt_local.foldmethod = 'expr'
  end,
})
