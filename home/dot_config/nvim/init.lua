require("config.base")
require("config.highlights")
require("config.lazy")
require("config.colorscheme")

if vim.g.started_by_firenvim then
	require("config.firenvim")
end

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config._private")
		require("config.keymaps")
	end,
})
