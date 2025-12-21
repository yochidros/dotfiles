local M = {
	"nvim-mini/mini.files",
	lazy = false,
	priority = 900,
	version = false,
}

function M.config()
	require("mini.files").setup({
		mappings = {
			go_in_plus = "<CR>",
			show_help = "?",
		},
		windows = {
			-- Maximum number of windows to show side by side
			max_number = math.huge,
			-- Whether to show preview of file/directory under cursor
			preview = false,
			-- Width of focused window
			width_focus = 150,
			-- Width of non-focused window
			width_nofocus = 60,
			-- Width of preview window
			width_preview = 120,
		},
	})
	vim.keymap.set("n", "<Leader>n", M["minifiles_toggle"], { noremap = true })
end

function M.minifiles_toggle()
	if not MiniFiles.close() then
		MiniFiles.open()
	end
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesWindowUpdate",
	callback = function(ev)
		local state = MiniFiles.get_explorer_state() or {}

		local win_ids = vim.tbl_map(function(t)
			return t.win_id
		end, state.windows or {})

		local function idx(win_id)
			for i, id in ipairs(win_ids) do
				if id == win_id then
					return i
				end
			end
		end

		local this_win_idx = idx(ev.data.win_id)
		local focused_win_idx = idx(vim.api.nvim_get_current_win())

		-- this_win_idx can be nil sometimes when opening fresh minifiles
		if this_win_idx and focused_win_idx then
			-- idx_offset is 0 for the currently focused window
			local idx_offset = this_win_idx - focused_win_idx

			-- the width of windows based on their distance from the center
			-- i.e. center window is 60, then next over is 20, then the rest are 10.
			-- Can use more resolution if you want like { 60, 30, 20, 15, 10, 5 }
			local widths = { 60, 20, 10 }

			local i = math.abs(idx_offset) + 1 -- because lua is 1-based lol
			local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
			win_config.width = i <= #widths and widths[i] or widths[#widths]

			local offset = 0
			for j = 1, math.abs(idx_offset) do
				local w = widths[j] or widths[#widths]
				-- add an extra +2 each step to account for the border width
				local _offset = 0.5 * (w + win_config.width) + 2
				if idx_offset > 0 then
					offset = offset + _offset
				elseif idx_offset < 0 then
					offset = offset - _offset
				end
			end

			win_config.height = idx_offset == 0 and 25 or 20
			win_config.row = math.floor(0.5 * (vim.o.lines - win_config.height))
			win_config.col = math.floor(0.5 * (vim.o.columns - win_config.width) + offset)
			vim.api.nvim_win_set_config(ev.data.win_id, win_config)
		end
	end,
})

return M
