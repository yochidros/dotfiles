local M = {
	"lambdalisue/fern-renderer-nerdfont.vim",
	event = "VeryLazy",
	dependencies = {
		"lambdalisue/glyph-palette.vim",
		{ "yuki-yano/fern-preview.vim", event = "BufReadPost" },
		{ "lambdalisue/fern-git-status.vim", event = "BufReadPost" },
	},
}

function M.config()
	vim.cmd('let g:fern#renderer = "nerdfont"')
	local command = vim.api.nvim_command
	command([[augroup my-glyph-palette]])
	command([[autocmd! *]])
	command([[autocmd FileType fern call glyph_palette#apply()]])
	command([[autocmd FileType nerdtree,startify call glyph_palette#apply()]])
	command([[augroup END]])

	command([[
	   function! s:fern_settings() abort
	     nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
	     nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
	     nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
	     nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
	     nmap <silent> <buffer> <C-r> <Plug>(fern-action-trash=)
	     nmap <silent> <buffer> <C-l> <C-w>l

	     "split command
	     nmap <silent> <buffer> <C-A-l> <Plug>(fern-action-open:vsplit)
	     nmap <silent> <buffer> <C-A-j> <Plug>(fern-action-open:split)
	   endfunction
	 ]])

	command([[augroup fern_settings]])
	command([[autocmd!]])
	command([[autocmd FileType fern call s:fern_settings()]])
	command([[augroup END]])
end

return M
