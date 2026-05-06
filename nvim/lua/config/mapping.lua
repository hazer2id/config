local lsp = require("config.lsp.common")

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

local function motion_without_underscore(motion)
  vim.opt.iskeyword:remove("_")
  vim.cmd("normal! " .. motion)
  vim.opt.iskeyword:append("_")
end

-- Normal
-- Cursor
vim.keymap.del('v', 'in')
vim.keymap.del('o', 'in')
vim.keymap.set(modes, "<Space>", "h")
vim.keymap.set(modes, "t", "j")
vim.keymap.set(modes, "e", "k")
vim.keymap.set(modes, "r", "l")
vim.keymap.set(modes, "c", "<c-d>")
vim.keymap.set(modes, "o", "<c-u>")
vim.keymap.set(modes, 'u', function() motion_without_underscore('b') end)
vim.keymap.set(modes, "U", "B")
vim.keymap.set(modes, 'l', function() motion_without_underscore('w') end)
vim.keymap.set(modes, "L", "W")
vim.keymap.set("v", 'u', function() motion_without_underscore('ge') end)
vim.keymap.set("v", 'l', function() motion_without_underscore('e') end)

-- Move
vim.keymap.set(modes, "k", "n")
vim.keymap.set(modes, "K", "N")
vim.keymap.set(modes, "b", "g;")
vim.keymap.set(modes, "B", "g,")
vim.keymap.set("n", "d", function()
  vim.diagnostic.jump({count=1, float=true})
end)
vim.keymap.set("n", "D", function()
  vim.diagnostic.jump({count=-1, float=true})
end)
-- Mode
vim.keymap.set(modes, "n", "o")
vim.keymap.set(modes, "N", "O")
vim.keymap.set(modes, "S", "R")
vim.keymap.set("v", "i", "c")
vim.keymap.set("v", "a", "c")
-- Operation
vim.keymap.set(modes, "z", "u")
vim.keymap.set(modes, "Z", "<c-r>")
vim.keymap.set("v", "Y", function()
  vim.cmd('normal! "zy')
  vim.fn.system({ "tmux", "load-buffer", "-" }, vim.fn.getreg("z"))
end)
vim.keymap.set(modes, "P", function()
  require("telescope.builtin").registers()
end)
-- LSP
vim.keymap.set(modes, "<Tab>", vim.lsp.buf.hover)
vim.keymap.set("i", "<CR>", function()
  lsp.completion_confirm("<CR>")
end)
vim.keymap.set('i', '<Tab>', function()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  else
    lsp.completion_next("<Tab>")
  end
end)
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
  end
end)
-- Etc
vim.keymap.set(modes, "m", ".")
vim.keymap.set(modes, "q", "@")
vim.keymap.set(modes, "Q", "q")
vim.keymap.set(modes, "f", "za")
vim.keymap.set(modes, "F", "zR")
vim.keymap.set(modes, "+", "<c-a>")
vim.keymap.set(modes, "-", "<c-x>")
vim.keymap.set(modes, "j", ":join<CR>")
vim.keymap.set(modes, "J", ":join!<CR>")
vim.keymap.set(modes, "h", ":noh<CR>")

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
leader_map("e", function() require('telescope.builtin').find_files() end)
leader_map("h", "split")
leader_map("v", "vsplit")
leader_map("p", "wincmd h")
leader_map("m", "wincmd j")
leader_map("a", "wincmd k")
leader_map("s", "wincmd l")
leader_map("r", "wincmd w")
leader_map("R", "wincmd p")
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
leader_map("d", "cnext")
leader_map("D", "cprev")
leader_map("i", function()
  local aerial = require("aerial")
  if aerial.is_open() then
    aerial.close()
  else
    aerial.open({ focus = true })
  end
end)
