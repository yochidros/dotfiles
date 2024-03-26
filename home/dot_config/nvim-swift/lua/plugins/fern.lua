local M = {
	"lambdalisue/fern.vim",
	lazy = false,
	priority = 499,
	dependencies = {
		"lambdalisue/fern-hijack.vim",
	},
}

function M.config()
	-- Fern
	vim.g.cursorhold_updatetime = 100
	vim.cmd("let g:fern#default_hidden=1")
	vim.keymap.set("n", "<Leader>n", ":Fern . -reveal=% -drawer -toggle -width=36<CR>", { noremap = true })
end

return M
