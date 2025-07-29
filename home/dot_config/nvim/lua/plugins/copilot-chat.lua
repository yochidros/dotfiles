local M = {
	"CopilotC-Nvim/CopilotChat.nvim",
	cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatClose", "CopilotChatAsk" },
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	},
	enabled = false,
	build = "make tiktoken", -- Only on MacOS or Linux
	opts = {
		mappings = {
			reset = {
				normal = "<C-/>",
				insert = "<C-/>",
			},
		},
		-- See Configuration section for options
	},
	-- See Commands section for default commands if you want to lazy load on them
}

-- vim.keymap.set("n", "<C-p>", function()
-- 	local window = require("CopilotChat").chat
-- 	if window:visible() then
-- 		if not window:focused() then
-- 			window:focus()
-- 		end
-- 	else
-- 		require("CopilotChat").open()
-- 	end
-- end, { desc = "Open or Focus Copilot Chat" })
--
-- vim.keymap.set("n", "<C-.>", function()
-- 	require("CopilotChat").close()
-- end, { desc = "Close Copilto Chat" })
--
-- vim.keymap.set("n", "<leader>?", function()
-- 	local input = vim.fn.input("Quick Chat: ")
-- 	if input ~= "" then
-- 		require("CopilotChat").ask(input, {
-- 			selection = require("CopilotChat.select").buffer,
-- 		})
-- 	end
-- end, { desc = "CopilotChat - Quick chat" })
--
-- vim.keymap.set("v", "?", function()
-- 	local input = vim.fn.input("Quick Selection Ask: ")
-- 	if input ~= "" then
-- 		require("CopilotChat").ask(input, {
-- 			selection = require("CopilotChat.select").visual,
-- 		})
-- 	end
-- end, { desc = "CopilotChat - Quick chat with selection" })
--
return M
