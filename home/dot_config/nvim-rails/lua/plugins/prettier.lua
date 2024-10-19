local M = {
	"MunifTanjim/prettier.nvim",
	ft = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
}
function M.config()
	local status, prettier = pcall(require, "prettier")
	if not status then
		return
	end
	prettier.setup({
		bin = "prettierd",
		filetypes = {
			"css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
	})
end

return M
