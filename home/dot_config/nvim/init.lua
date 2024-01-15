require("config.base")
require("config.highlights")
require("config.private_path")
require("config.lazy")

if vim.g.started_by_firenvim then
	require("config.firenvim")
end

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.keymaps")
	end,
})
