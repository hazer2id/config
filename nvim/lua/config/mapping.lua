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
vim.keymap.set(modes, "f", "h")
vim.keymap.set(modes, "i", "j")
vim.keymap.set(modes, "o", "k")
vim.keymap.set(modes, "n", "l")
vim.keymap.set(modes, "F", "^")
vim.keymap.set(modes, "I", "<c-d>")
vim.keymap.set(modes, "O", "<c-u>")
vim.keymap.set(modes, "N", "$")
-- Move
vim.keymap.set(modes, "k", "n")
vim.keymap.set(modes, "K", "N")
vim.keymap.set(modes, "l", "w")
vim.keymap.set(modes, "L", "W")
vim.keymap.set(modes, "w", "b")
vim.keymap.set(modes, "W", "B")
vim.keymap.set("v", "l", "e")
vim.keymap.set(modes, "b", "g;")
vim.keymap.set(modes, "B", "g,")
vim.keymap.set("n", "d", function()
  vim.diagnostic.jump({count=1, float=true})
end)
vim.keymap.set("n", "D", function()
  vim.diagnostic.jump({count=-1, float=true})
end)
-- Mode
vim.keymap.set(modes, "s", "v")
vim.keymap.set(modes, "S", "V")
vim.keymap.set(modes, "<c-s>", "<c-v>")
vim.keymap.set(modes, "r", "o")
vim.keymap.set(modes, "R", "O")
vim.keymap.set(modes, "e", "i")
vim.keymap.set(modes, "E", "a")
vim.keymap.set(modes, "<c-e>", "R")
vim.keymap.set("v", "e", "c")
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
vim.keymap.set(modes, "<Tab>", vim.lsp.buf.hover)
vim.keymap.set("i", "<Tab>", function()
  lsp.completion_next("<Tab>")
end)
vim.keymap.set("i", "<CR>", function()
  lsp.completion_confirm("<CR>")
end)
-- Etc
vim.keymap.set("n", "<Space>", "o<Esc>")
vim.keymap.set(modes, "q", "@")
vim.keymap.set(modes, "Q", "q")
vim.keymap.set(modes, "z", "za")
vim.keymap.set(modes, "Z", "zR")
vim.keymap.set(modes, "+", "<c-a>")
vim.keymap.set(modes, "-", "<c-x>")
vim.keymap.set(modes, "j", ":join<CR>")
vim.keymap.set(modes, "J", ":.-1join<CR>")
vim.keymap.set(modes, "m", ":noh<CR>")

-- GoTo
vim.keymap.set(modes, "gh", vim.lsp.buf.incoming_calls)
vim.keymap.set(modes, "gH", vim.lsp.buf.outgoing_calls)
vim.keymap.set(modes, "gi", vim.lsp.buf.implementation)
vim.keymap.set(modes, "gd", vim.lsp.buf.definition)
vim.keymap.set(modes, "gD", vim.lsp.buf.declaration)
vim.keymap.set(modes, "gr", vim.lsp.buf.references)
vim.keymap.set(modes, "gn", vim.lsp.buf.rename)
vim.keymap.set(modes, "gs", vim.lsp.buf.code_action)

-- Leader
vim.keymap.set("i", "<leader><Tab>", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
    "n",
    false
  )
end)
leader_map("x", "wqall")
leader_map("t", function()
	require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",
    select_buffer = true,
  })
end)
leader_map("s", telescope.find_files)
leader_map("z", "split")
leader_map("Z", "vsplit")
leader_map("f", "wincmd h")
leader_map("i", "wincmd j")
leader_map("o", "wincmd k")
leader_map("n", "wincmd l")
leader_map("r", "wincmd w")
leader_map("R", "wincmd p")
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
leader_map("b", 'execute "normal! \\<c-o>"')
leader_map("B", 'execute "normal! \\<c-i>"')
leader_map("l", "cnext")
leader_map("w", "cprev")
