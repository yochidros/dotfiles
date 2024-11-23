local M = {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	event = "VeryLazy",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	-- 	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	-- 	-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	-- 	"BufReadPre "
	-- 		.. vim.fn.expand("~/yochidros/my-obsidian")
	-- 		.. "**.md",
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"oflisback/obsidian-bridge.nvim",
			dependencies = { "nvim-telescope/telescope.nvim" },
			event = {
				"BufReadPre *.md",
				"BufNewFile *.md",
			},
		},
	},
}
function M.config()
	if not string.match(vim.loop.cwd(), "obsidian") then
		return
	end
	local status, obsidian = pcall(require, "obsidian")
	if not status then
		return
	end
	require("obsidian-bridge").setup({
		obsidian_server_address = "http://localhost:27123",
		scroll_sync = true,
	})
	vim.cmd("set conceallevel=1")
	obsidian.setup({
		workspaces = {
			{
				name = "root",
				path = os.getenv("OBSIDIAN_HOME"),
			},
			{
				name = "daily",
				path = os.getenv("OBSIDIAN_HOME") .. "/daily-notes",
			},
		},
		ui = {
			enable = true,
		},
		templates = {
			subdir = "Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "daily-notes/2024",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "nvim_daily_template.md",
		},
		attachments = {
			img_folder = "Asset", -- This is the default
		},
	})
end

return M
