local M = {
	"jackMort/ChatGPT.nvim",
	lazy = not vim.g.started_by_firenvim,
	enabled = false,
	event = "VeryLazy",
	config = function()
		if vim.g.started_by_firenvim then
			return
		end
		if vim.fn.system("echo $OPENAI_API_KEY") == "" then
			return
		end
		require("chatgpt").setup({
			openai_params = {
				model = "gpt-4",
			},
			openai_edit_params = {
				model = "code-davinci-edit-002",
			},
			actions_paths = { "~/.config/nvim/custom_actions.json" },
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
return M
