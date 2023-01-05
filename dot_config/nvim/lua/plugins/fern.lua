local M = {
	"lambdalisue/fern.vim",
	lazy = false,
	priority = 499,
	dependencies = {
		-- 	{ "yuki-yano/fern-preview.vim", event = "BufReadPost" },
		-- 	{ "lambdalisue/fern-git-status.vim", event = "BufReadPost" },
		"lambdalisue/fern-hijack.vim",
		-- "lambdalisue/fern-renderer-nerdfont.vim",
		-- "lambdalisue/glyph-palette.vim",
	},
}

function M.config()
	-- Fern
	vim.g.cursorhold_updatetime = 100
	vim.cmd("let g:fern#default_hidden=1")
	--vim.cmd('let g:fern#renderer = "nerdfont"')
	vim.keymap.set("n", "<Leader>n", ":Fern . -reveal=% -drawer -toggle -width=36<CR>", { noremap = true })
end

return M
