require("config.base")
require("config.lazy")
require("config.colorscheme")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.highlights")
		require("config._private")
		require("config.keymaps")
	end,
})
