local M = {
	"tpope/vim-fugitive",
	event = "VeryLazy",
}
function M.config()
	-- 記号の色を変更する
	vim.cmd("highlight GitGutterAdd ctermfg=green")
	vim.cmd("highlight GitGutterChange ctermfg=blue")
	vim.cmd("highlight GitGutterDelete ctermfg=red")
end

return M
