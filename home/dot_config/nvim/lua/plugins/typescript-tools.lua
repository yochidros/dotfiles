local M = {
	"pmizio/typescript-tools.nvim",
	event = "VeryLazy",
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "saghen/blink.cmp" },
}

function M.config()
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	require("typescript-tools").setup({
		capabilities = capabilities,
	})
end
return M
