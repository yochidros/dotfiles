local M = {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
}

function M.setup_local(config)
	require("typescript-tools").setup(config)
end
return M
