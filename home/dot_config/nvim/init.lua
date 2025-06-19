require("config.base")
require("config.highlights")
require("config.private_path")
require("config.dark_mode")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.keymaps")
	end,
})
