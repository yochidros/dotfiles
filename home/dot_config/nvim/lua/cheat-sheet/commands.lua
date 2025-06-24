local M = {}

local cheat_sheet

M.setup = function()
	cheat_sheet = require("cheat-sheet")
	
	vim.api.nvim_create_user_command("CheatSheet", function(opts)
		if opts.args and opts.args ~= "" then
			cheat_sheet.search(opts.args)
		else
			cheat_sheet.show()
		end
	end, {
		nargs = "?",
		desc = "Open cheat sheet with optional search query",
		complete = function(arglead, cmdline, cursorpos)
			local suggestions = {
				"basic", "movement", "editing", "visual", "search",
				"buffers", "windows", "git", "lsp", "telescope"
			}
			return vim.tbl_filter(function(item)
				return item:sub(1, #arglead) == arglead
			end, suggestions)
		end,
	})
	
	vim.api.nvim_create_user_command("CheatSheetToggle", function()
		cheat_sheet.toggle()
	end, {
		desc = "Toggle cheat sheet window",
	})
	
	vim.api.nvim_create_user_command("CheatSheetSearch", function(opts)
		cheat_sheet.search(opts.args)
	end, {
		nargs = 1,
		desc = "Search cheat sheet commands",
	})
end

return M