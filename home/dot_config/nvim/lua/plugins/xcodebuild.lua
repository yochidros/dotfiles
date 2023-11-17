local M = {
	"wojciech-kulik/xcodebuild.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("xcodebuild").setup({})
	end,
}

-- function M.setup()
-- 	print("not setup xcodebuild")
-- 	local status, xcodebuild = pcall(require, "xcodebuild")
-- 	if not status then
-- 		print("not setup xcodebuild")
-- 		return
-- 	end
-- 	xcodebuild.setup({})
-- 	print("setup xcodebuild")
-- end
return M
