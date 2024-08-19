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
