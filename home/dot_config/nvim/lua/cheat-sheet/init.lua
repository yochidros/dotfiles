local M = {}

local config = require("cheat-sheet.config")
local ui = require("cheat-sheet.ui")
local commands = require("cheat-sheet.commands")

M.setup = function(opts)
	config.setup(opts)
	commands.setup()
end

M.toggle = function()
	ui.toggle()
end

M.show = function(category)
	ui.show(category)
end

M.search = function(query)
	ui.search(query)
end

return M