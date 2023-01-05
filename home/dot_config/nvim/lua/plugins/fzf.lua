local M = {
	"junegunn/fzf.vim",
	event = "VeryLazy",
	dependencies = {
		{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	},
}
function M.config()
	vim.api.nvim_exec(
		[[
" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>
" fbでバッファ検索を開く
" flで開いているファイルの文字列検索を開く
nnoremap fl :BLines<CR>
" fmでマーク検索を開く
nnoremap fm :Marks<CR>
" fhでファイル閲覧履歴検索を開く
nnoremap fh :History<CR>
" fcでコミット履歴検索を開く
nnoremap fc :Commits<CR>
]],
		false
	)
end

return M
