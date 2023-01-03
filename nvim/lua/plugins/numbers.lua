local M = {
	"myusuf3/numbers.vim",
	event = "InsertEnter",
}

function M.config()
	local status, number = pcall(require, "numbers")
	if not status then
		return
	end

	vim.api.nvim_command([[
    let g:numbers_exclude = ['alpha', 'tagbar','w3m', 'Fern', 'vimshell', 'bufferline']
  ]])
end

return M
