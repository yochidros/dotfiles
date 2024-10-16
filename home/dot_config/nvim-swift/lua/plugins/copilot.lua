local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
	enable = false,
}

function M.config()
	vim.g.copilot_proxy_strict_ssl = false
	require("copilot").setup({
		server_opts_overrides = {
			trace = "verbose",
		},
	})
end
return M
