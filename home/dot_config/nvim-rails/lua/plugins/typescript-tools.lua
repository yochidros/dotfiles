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
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
}

function M.config()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("typescript-tools").setup({
		capabilities = capabilities,
	})
end
return M
