local lsp = require("config.lsp.common")
local telescope = require('telescope.builtin')

local modes = {"n", "v", "o"}
local function leader_map(lhs, rhs)
	local run = function()
		if type(rhs) == "function" then
			rhs()
		else
			vim.cmd(rhs)
		end
	end

	vim.keymap.set({"n", "v", "o"}, "<leader>" .. lhs, run)
	vim.keymap.set("i", "<leader>" .. lhs, function()
		vim.cmd("stopinsert")
		run()
	end)
end

-- Normal
-- Cursor
vim.keymap.set(modes, "t", "h")
vim.keymap.set(modes, "<Space>", "j")
vim.keymap.set(modes, "e", "k")
vim.keymap.set(modes, "n", "l")
vim.keymap.set(modes, "T", "^")
vim.keymap.set(modes, "N", "$")
-- Move
vim.keymap.set(modes, "k", "n")
vim.keymap.set(modes, "K", "N")
vim.keymap.set(modes, "W", "b")
vim.keymap.set("v", "w", "e")
vim.keymap.set(modes, "b", "g;")
vim.keymap.set(modes, "B", "g,")
vim.keymap.set("n", "q", function()
  vim.diagnostic.jump({count=1, float=true})
end)
vim.keymap.set("n", "Q", function()
  vim.diagnostic.jump({count=-1, float=true})
end)
-- Mode
vim.keymap.set(modes, "s", "v")
vim.keymap.set(modes, "S", "V")
vim.keymap.set(modes, "<c-s>", "<c-v>")
vim.keymap.set(modes, "r", "s")
vim.keymap.set("v", "i", "c")
vim.keymap.set("v", "a", "c")
-- Operation
vim.keymap.set(modes, "c", "y")
vim.keymap.set("v", "C", function()
  vim.cmd('normal! "zy')
  vim.fn.system({ "tmux", "load-buffer", "-" }, vim.fn.getreg("z"))
end)
vim.keymap.set(modes, "P", function()
  require("telescope.builtin").registers()
end)
-- LSP
vim.keymap.set(modes, "h", vim.lsp.buf.hover)
vim.keymap.set("i", "<Tab>", function()
  lsp.completion_next("<Tab>")
end)
vim.keymap.set("i", "<CR>", function()
  lsp.completion_confirm("<CR>")
end)
-- Etc
vim.keymap.set(modes, "f", "za")
vim.keymap.set(modes, "F", "zR")
vim.keymap.set(modes, "+", "<c-a>")
vim.keymap.set(modes, "-", "<c-x>")
vim.keymap.set(modes, "j", ":join<CR>")
vim.keymap.set(modes, "J", ":.-1join<CR>")
vim.keymap.set(modes, "m", ":noh<CR>")

-- GoTo
vim.keymap.set(modes, "gb", "<c-o>")
vim.keymap.set(modes, "gB", "<c-i>")
vim.keymap.set(modes, "gc", vim.lsp.buf.incoming_calls)
vim.keymap.set(modes, "gC", vim.lsp.buf.outgoing_calls)
vim.keymap.set(modes, "gi", vim.lsp.buf.implementation)
vim.keymap.set(modes, "gd", vim.lsp.buf.definition)
vim.keymap.set(modes, "gD", vim.lsp.buf.declaration)
vim.keymap.set(modes, "gr", vim.lsp.buf.references)
vim.keymap.set(modes, "gn", vim.lsp.buf.rename)
vim.keymap.set(modes, "gs", vim.lsp.buf.code_action)
vim.keymap.set(modes, "gq", ":cnext<CR>")
vim.keymap.set(modes, "gQ", ":cprev<CR>")

-- Leader
leader_map("<leader>q", function()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("cwindow")
end)
vim.keymap.set("i", "<leader><Tab>", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
    "n",
    false
  )
end)
leader_map("x", "wqall")
leader_map("f", function()
	require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",
    select_buffer = true,
  })
end)
leader_map("s", telescope.find_files)
leader_map("b", telescope.buffers)
leader_map("z", ":split<CR>")
leader_map("Z", ":vsplit<CR>")
leader_map("m", "wincmd h")
leader_map("p", "wincmd j")
leader_map("a", "wincmd k")
leader_map("r", "wincmd l")
leader_map("n", "wincmd w")
leader_map("N", "wincmd p")
leader_map("c", "close")
leader_map("+", "resize +5")
leader_map("-", "resize -5")
leader_map("<", "vertical resize -5")
leader_map(">", "vertical resize +5")
leader_map("=", "wincmd =")
leader_map("q", function()
  local current_win = vim.api.nvim_get_current_win()

  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end

  vim.cmd("copen")
  vim.api.nvim_set_current_win(current_win)
end)
