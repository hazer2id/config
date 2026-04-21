vim.opt.mouse = ""
vim.opt.relativenumber = true

-- Autowrite
vim.opt.autowriteall = true
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    if vim.bo.buftype == ""
      and vim.bo.modified
      and vim.bo.modifiable
      and not vim.bo.readonly
      and vim.fn.expand("%") ~= ""
    then
      vim.cmd("silent! write")
      vim.api.nvim_exec_autocmds("BufWritePost", { buffer = 0 })
    end
  end,
})

vim.opt.wildignore = {
	".git",
	".next",
	"node_modules",
	"__pycache__",
	".build",
	".cache",
	"*.db",
	"*.o",
	".eslintrc.json",
	"instance",
  "lazy-lock.json",
}
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.smartindent = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c", "cpp", "make"},
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.colorcolumn = "80"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = {"en", "cjk"}
  end,
})
vim.opt.completeopt = { "menu", "menuone", "popup", "noselect" }

local modules = {
  "lazy",
  "lsp",
  "fold",
  "mapping",
}
for _, module in ipairs(modules) do
  require("config." .. module)
end
