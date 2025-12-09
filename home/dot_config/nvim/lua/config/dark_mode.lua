is_dark_mode = true

local function eval_dark_mode()
	if vim.fn.has("macunix") == 1 then
		local dark_mode = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
		if is_dark_mode == dark_mode then
			return false
		end
		if string.find(dark_mode, "Dark") then
			is_dark_mode = true
		else
			is_dark_mode = false
		end
		return true
	end
end

eval_dark_mode()

local timer = vim.loop.new_timer()
timer:start(
	4000,
	5000, -- 5s
	vim.schedule_wrap(function()
		if not eval_dark_mode() then
			return
		end
		require("plugins.lualine").refresh()
		if is_dark_mode then
			vim.api.nvim_set_option_value("background", "dark", {})
		else
			vim.api.nvim_set_option_value("background", "light", {})

			-- git signs colors
			vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#48dd98" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff2039" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#fabd2f" })
		end
	end)
)

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		if timer:is_active() then
			timer:stop()
			timer:close()
		end
	end,
})
