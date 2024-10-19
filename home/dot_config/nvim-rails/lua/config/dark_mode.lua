is_dark_mode = true

function eval_dark_mode()
	if vim.fn.has("macunix") == 1 then
		local dark_mode = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
		if string.find(dark_mode, "Dark") then
			is_dark_mode = true
		else
			is_dark_mode = false
		end
	end
end

eval_dark_mode()

local timer = vim.loop.new_timer()
timer:start(
	4000,
	5000, -- 5s
	vim.schedule_wrap(function()
		eval_dark_mode()
		if is_dark_mode then
			vim.api.nvim_set_option_value("background", "dark", {})
		else
			vim.api.nvim_set_option_value("background", "light", {})
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
