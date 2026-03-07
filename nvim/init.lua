vim.opt.relativenumber = true
vim.opt.autowriteall = true
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
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

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
