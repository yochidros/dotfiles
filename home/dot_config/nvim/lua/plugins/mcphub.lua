local M = {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
	cmd = "MCPHub",
	config = function()
		local mcp = require("mcphub")
		mcp.setup({
			extensions = {
				avante = {
					make_slash_commands = true, -- make /slash commands from MCP server prompts
				},
			},
		})
	end,
}
return M
