return {
	"MeanderingProgrammer/render-markdown.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		file_types = { "markdown", "copilot-chat", "Avante", "txt", "Sidekick" },
	},
	ft = { "markdown", "Avante", "txt", "copilot-chat" },
}
