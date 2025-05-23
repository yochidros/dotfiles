local M = {
	"myusuf3/numbers.vim",
	event = "InsertEnter",
}

function M.config()
	local status, _ = pcall(require, "numbers")
	if not status then
		return
	end

	vim.api.nvim_command([[
    let g:numbers_exclude = ['alpha', 'tagbar','w3m', 'Fern', 'vimshell', 'bufferline', 'terminal']
  ]])
end

return M
