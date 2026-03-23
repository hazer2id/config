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
vim.keymap.set(modes, "t", "w")
vim.keymap.set(modes, "T", "b")
vim.keymap.set("v", "t", "e")
vim.keymap.set(modes, "b", "g;")
vim.keymap.set(modes, "B", "g,")
vim.keymap.set("n", "w", function()
  vim.diagnostic.jump({count=1, float=true})
end)
vim.keymap.set("n", "W", function()
  vim.diagnostic.jump({count=-1, float=true})
end)
-- Mode
vim.keymap.set(modes, "l", "o")
vim.keymap.set(modes, "L", "O")
vim.keymap.set(modes, "e", "i")
vim.keymap.set(modes, "E", "I")
vim.keymap.set("v", "e", "c")
vim.keymap.set("v", "a", "c")
vim.keymap.set(modes, "s", "v")
vim.keymap.set(modes, "S", "V")
vim.keymap.set(modes, "<c-s>", "<c-v>")
vim.keymap.set(modes, "r", "s")
-- Operation
vim.keymap.set(modes, "<Backspace>", "X")
vim.keymap.set("v", "Y", function()
  vim.cmd('normal! "zy')
  vim.fn.system({ "tmux", "load-buffer", "-" }, vim.fn.getreg("z"))
end)
vim.keymap.set(modes, "P", function()
  require("telescope.builtin").registers()
end)
-- LSP
vim.keymap.set(modes, "<Space>", vim.lsp.buf.hover)
vim.keymap.set("i", "<Tab>", function()
  lsp.completion_next("<Tab>")
end)
vim.keymap.set("i", "<CR>", function()
  lsp.completion_confirm("<CR>")
end)
-- Etc
vim.keymap.set(modes, "z", "za")
vim.keymap.set(modes, "Z", "zR")
vim.keymap.set(modes, "+", "<c-a>")
vim.keymap.set(modes, "-", "<c-x>")
vim.keymap.set(modes, "j", ":join<CR>")
vim.keymap.set(modes, "J", ":.-1join<CR>")
vim.keymap.set(modes, "h", ":noh<CR>")

-- GoTo
vim.keymap.set(modes, "gb", "<c-o>")
vim.keymap.set(modes, "gB", "<c-i>")
vim.keymap.set(modes, "gh", vim.lsp.buf.incoming_calls)
vim.keymap.set(modes, "gH", vim.lsp.buf.outgoing_calls)
vim.keymap.set(modes, "gi", vim.lsp.buf.implementation)
vim.keymap.set(modes, "gd", vim.lsp.buf.definition)
vim.keymap.set(modes, "gD", vim.lsp.buf.declaration)
vim.keymap.set(modes, "gr", vim.lsp.buf.references)
vim.keymap.set(modes, "gn", vim.lsp.buf.rename)
vim.keymap.set(modes, "gs", vim.lsp.buf.code_action)
vim.keymap.set(modes, "gq", ":cnext<CR>")
vim.keymap.set(modes, "gQ", ":cprev<CR>")

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
leader_map("b", telescope.buffers)
leader_map("z", ":split<CR>")
leader_map("Z", ":vsplit<CR>")
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
