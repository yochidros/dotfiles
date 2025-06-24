local M = {}

local config = require("cheat-sheet.config")
local data = require("cheat-sheet.data")

local state = {
	buf = nil,
	win = nil,
	current_category = nil,
	search_query = "",
	filtered_commands = {},
	selected_line = 1,
}

local move_cursor

local function close_window()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
	end
	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		vim.api.nvim_buf_delete(state.buf, { force = true })
	end
	state.buf = nil
	state.win = nil
end

local function setup_keymaps()
	local opts = { buffer = state.buf, silent = true, noremap = true }
	
	for _, key in ipairs(config.options.keymaps.close) do
		vim.keymap.set("n", key, close_window, opts)
	end
	
	for _, key in ipairs(config.options.keymaps.execute) do
		vim.keymap.set("n", key, execute_command, opts)
	end
	
	for _, key in ipairs(config.options.keymaps.copy) do
		vim.keymap.set("n", key, copy_command, opts)
	end
	
	vim.keymap.set("n", "/", start_search, opts)
	vim.keymap.set("n", "j", function() move_cursor(1) end, opts)
	vim.keymap.set("n", "k", function() move_cursor(-1) end, opts)
	vim.keymap.set("n", "<Down>", function() move_cursor(1) end, opts)
	vim.keymap.set("n", "<Up>", function() move_cursor(-1) end, opts)
end

local function setup_highlights()
	local opts = config.options.highlight
	
	vim.api.nvim_set_hl(0, "CheatSheetCategory", { link = opts.category })
	vim.api.nvim_set_hl(0, "CheatSheetCommand", { link = opts.command })
	vim.api.nvim_set_hl(0, "CheatSheetDescription", { link = opts.description })
	vim.api.nvim_set_hl(0, "CheatSheetKey", { link = opts.key })
end

local function create_window()
	local opts = config.options
	local width = opts.window.width
	local height = opts.window.height
	
	local row = opts.window.row or math.floor((vim.o.lines - height) / 2)
	local col = opts.window.col or math.floor((vim.o.columns - width) / 2)
	
	state.buf = vim.api.nvim_create_buf(false, true)
	
	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = opts.window.border,
		title = opts.window.title,
		title_pos = "center",
		style = "minimal",
	}
	
	state.win = vim.api.nvim_open_win(state.buf, true, win_opts)
	
	vim.api.nvim_buf_set_option(state.buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(state.buf, "filetype", "cheat-sheet")
	vim.api.nvim_win_set_option(state.win, "wrap", false)
	vim.api.nvim_win_set_option(state.win, "cursorline", true)
	
	setup_keymaps()
	setup_highlights()
end

local function get_all_commands()
	local all_commands = {}
	local commands = vim.tbl_extend("force", data.commands, data.get_contextual_commands())
	
	for category, category_data in pairs(commands) do
		if vim.tbl_contains(config.options.categories.enabled, category) then
			table.insert(all_commands, {
				type = "category",
				name = category_data.name,
				icon = category_data.icon,
				category = category,
			})
			
			for _, cmd in ipairs(category_data.commands) do
				table.insert(all_commands, {
					type = "command",
					key = cmd.key,
					desc = cmd.desc,
					category = category,
				})
			end
			
			table.insert(all_commands, { type = "separator" })
		end
	end
	
	return all_commands
end

local function filter_commands(query)
	if query == "" then
		return get_all_commands()
	end
	
	local filtered = {}
	local all_commands = get_all_commands()
	
	for _, item in ipairs(all_commands) do
		if item.type == "command" then
			local match = false
			
			if not config.options.search.case_sensitive then
				query = query:lower()
				match = item.key:lower():find(query) or item.desc:lower():find(query)
			else
				match = item.key:find(query) or item.desc:find(query)
			end
			
			if match then
				table.insert(filtered, item)
			end
		else
			table.insert(filtered, item)
		end
	end
	
	return filtered
end

local function render_buffer()
	if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
		return
	end
	
	local lines = {}
	local highlights = {}
	
	if state.search_query ~= "" then
		table.insert(lines, "Search: " .. state.search_query)
		table.insert(lines, "")
		table.insert(highlights, { line = 0, col_start = 0, col_end = -1, hl_group = "CheatSheetCategory" })
	end
	
	local commands = filter_commands(state.search_query)
	
	for i, item in ipairs(commands) do
		if item.type == "category" then
			local line = string.format("%s %s", item.icon, item.name)
			table.insert(lines, line)
			table.insert(highlights, { line = #lines - 1, col_start = 0, col_end = -1, hl_group = "CheatSheetCategory" })
		elseif item.type == "command" then
			local key_width = 20
			local key_padded = string.format("%-" .. key_width .. "s", item.key)
			local line = string.format("  %s %s", key_padded, item.desc)
			table.insert(lines, line)
			
			table.insert(highlights, { line = #lines - 1, col_start = 2, col_end = 2 + #item.key, hl_group = "CheatSheetKey" })
			table.insert(highlights, { line = #lines - 1, col_start = key_width + 3, col_end = -1, hl_group = "CheatSheetDescription" })
		elseif item.type == "separator" then
			table.insert(lines, "")
		end
	end
	
	vim.api.nvim_buf_set_option(state.buf, "modifiable", true)
	vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(state.buf, "modifiable", false)
	
	for _, hl in ipairs(highlights) do
		vim.api.nvim_buf_add_highlight(state.buf, -1, hl.hl_group, hl.line, hl.col_start, hl.col_end)
	end
	
	state.filtered_commands = commands
end

move_cursor = function(direction)
	local line_count = vim.api.nvim_buf_line_count(state.buf)
	local current_line = vim.api.nvim_win_get_cursor(state.win)[1]
	
	local new_line = current_line + direction
	new_line = math.max(1, math.min(new_line, line_count))
	
	vim.api.nvim_win_set_cursor(state.win, { new_line, 0 })
end

local function get_current_command()
	local line_num = vim.api.nvim_win_get_cursor(state.win)[1]
	local offset = state.search_query ~= "" and 3 or 1
	
	local command_index = line_num - offset + 1
	if command_index > 0 and command_index <= #state.filtered_commands then
		local item = state.filtered_commands[command_index]
		if item.type == "command" then
			return item
		end
	end
	return nil
end

function execute_command()
	local cmd = get_current_command()
	if cmd then
		close_window()
		vim.defer_fn(function()
			if cmd.key:match("^:") then
				vim.cmd(cmd.key:sub(2))
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd.key, true, false, true), "n", false)
			end
		end, 10)
	end
end

function copy_command()
	local cmd = get_current_command()
	if cmd then
		vim.fn.setreg("+", cmd.key)
		vim.notify("Copied: " .. cmd.key)
	end
end

function start_search()
	vim.ui.input({ prompt = config.options.search.prompt }, function(input)
		if input then
			state.search_query = input
			render_buffer()
		end
	end)
end

M.toggle = function()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		close_window()
	else
		M.show()
	end
end

M.show = function(category)
	create_window()
	state.current_category = category
	state.search_query = ""
	render_buffer()
end

M.search = function(query)
	if not state.win or not vim.api.nvim_win_is_valid(state.win) then
		M.show()
	end
	
	state.search_query = query or ""
	render_buffer()
end

return M