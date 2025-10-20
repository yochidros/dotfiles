local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("window-config-reloaded", function(window, pane)
	window:toast_notification("wezterm", "Configuration Reloaded", nil, 4000)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	if tab.is_active then
		return {
			{ Text = " " .. tab.tab_index + 1 .. " " },
		}
	end
	return {
		{ Text = string.format(" %d ", tab.tab_index + 1) },
	}
end)

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S")
	local name = window:active_key_table()
	if name then
		name = name
		local color = "#808080"
		if name == "resize_pane" then
			color = "#3a2a5e"
			name = "RESIZE NANE"
		elseif name == "copy_mode" then
			name = "COPY MODE"
			color = "#ba972f"
		end

		window:set_right_status(wezterm.format({
			{ Attribute = { Underline = "Single" } },
			{ Attribute = { Italic = true } },
			{ Background = { Color = color } },
			{ Text = "    [  " .. name .. "  ]    " },
		}))
		return
	end
	window:set_right_status(name or wezterm.format({
		{ Foreground = { AnsiColor = "Fuchsia" } },
		{ Attribute = { Italic = true } },
		{ Text = "`Ctrl-s` = <LEADER>  " .. date .. " " },
	}))
end)
function recompute_padding(window)
	local window_dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}

	if not window_dims.is_full_screen then
		if not overrides.window_padding then
			-- not changing anything
			overrides.window_padding = nil
		else
			-- Use only the middle 33%
			local third = math.floor(window_dims.pixel_width / 3)
			local new_padding = {
				left = third,
				right = third,
				top = 0,
				bottom = 0,
			}
			if overrides.window_padding and new_padding.left == overrides.window_padding.left then
				-- padding is same, avoid triggering further changes
				return
			end
			overrides.window_padding = new_padding
		end
		window:set_config_overrides(overrides)
	end
end

wezterm.on("window-resized", function(window, pane)
	recompute_padding(window)
end)

wezterm.on("window-config-reloaded", function(window)
	recompute_padding(window)
end)

local fish_path = function()
	if wezterm.target_triple == "aarch64-apple-darwin" then
		return "/opt/homebrew/bin/fish"
	else
		return "/usr/local/bin/fish"
	end
end

color_scheme = "GruvboxDarkHard"

if wezterm.gui then
	is_dark = wezterm.gui.get_appearance():find("Dark")
	if is_dark then
		color_scheme = "GruvboxDarkHard"
	else
		color_scheme = "GruvboxLight"
	end
end

return {
	use_ime = true,
	macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
	font = wezterm.font_with_fallback({
		"Comic Mono",
		"MesloLGS NF",
		"Hiragino Sans",
		"SF Pro Display",
		"Noto Color Emoji",
	}),
	-- front_end = "WebGpu",
	front_end = "OpenGL", -- Workaround for macOS 26 above. This issue is cursor moving is delayed after a while.
	color_scheme = color_scheme,
	warn_about_missing_glyphs = false,
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	leader = { key = "s", mods = "CTRL" },
	keys = {
		{
			key = "[",
			mods = "LEADER",
			action = act.Multiple({
				act.ActivateCopyMode,
				act.ActivateKeyTable({
					name = "copy_mode",
					one_shot = false,
				}),
			}),
		},
		{
			key = "r",
			mods = "CMD",
			action = wezterm.action.ReloadConfiguration,
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		},
		{
			key = "w",
			mods = "LEADER",
			action = act.ShowTabNavigator,
		},
		{
			key = "p",
			mods = "LEADER",
			action = act.ShowLauncher,
		},
		{
			key = "b",
			mods = "LEADER",
			action = act.RotatePanes("CounterClockwise"),
		},
		{ key = "n", mods = "LEADER", action = act.RotatePanes("Clockwise") },

		{
			key = "S",
			mods = "LEADER",
			action = act.PaneSelect({
				mode = "SwapWithActive",
			}),
		},
		-- Split
		{
			key = "|",
			mods = "LEADER",
			action = act.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "-",
			mods = "LEADER",
			action = act.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		-- Toggle Zoom
		{
			key = "=",
			mods = "LEADER",
			action = act.TogglePaneZoomState,
		},
		-- Create new tab
		{
			key = "c",
			mods = "LEADER",
			action = act.SpawnTab("DefaultDomain"),
		},
		{
			key = "x",
			mods = "LEADER",
			action = act.CloseCurrentPane({
				confirm = false,
			}),
		},
		{
			key = "1",
			mods = "LEADER",
			action = act.ActivateTab(0),
		},
		{
			key = "2",
			mods = "LEADER",
			action = act.ActivateTab(1),
		},
		{
			key = "3",
			mods = "LEADER",
			action = act.ActivateTab(2),
		},
		{
			key = "4",
			mods = "LEADER",
			action = act.ActivateTab(3),
		},
		{
			key = "5",
			mods = "LEADER",
			action = act.ActivateTab(4),
		},
		{
			key = "6",
			mods = "LEADER",
			action = act.ActivateTab(5),
		},

		-- Activate Pane
		{
			key = "h",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		},
	},
	key_tables = {
		resize_pane = {
			{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 5 }) },
			{ key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },

			{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 5 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },

			{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 5 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },

			{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 5 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },

			-- Cancel the mode by pressing escape
			{ key = "Enter", action = "PopKeyTable" },
			{ key = "Escape", action = "PopKeyTable" },
		},
		copy_mode = {
			{
				key = "Enter",
				mods = "NONE",
				action = act.Multiple({
					{ CopyTo = "Clipboard" },
					{ CopyMode = "Close" },
					"PopKeyTable",
				}),
			},
			{
				key = "Tab",
				mods = "NONE",
				action = act.CopyMode("MoveForwardWord"),
			},
			{
				key = "Tab",
				mods = "SHIFT",
				action = act.CopyMode("MoveBackwardWord"),
			},
			{
				key = "Escape",
				mods = "NONE",
				action = act.Multiple({
					{ CopyMode = "Close" },
					"PopKeyTable",
				}),
			},
			{
				key = "Space",
				mods = "NONE",
				action = act.CopyMode({ SetSelectionMode = "Cell" }),
			},
			{
				key = "$",
				mods = "NONE",
				action = act.CopyMode("MoveToEndOfLineContent"),
			},
			{
				key = "$",
				mods = "SHIFT",
				action = act.CopyMode("MoveToEndOfLineContent"),
			},
			{
				key = "0",
				mods = "NONE",
				action = act.CopyMode("MoveToStartOfLine"),
			},
			{
				key = "G",
				mods = "NONE",
				action = act.CopyMode("MoveToScrollbackBottom"),
			},
			{
				key = "G",
				mods = "SHIFT",
				action = act.CopyMode("MoveToScrollbackBottom"),
			},
			{
				key = "H",
				mods = "NONE",
				action = act.CopyMode("MoveToViewportTop"),
			},
			{
				key = "H",
				mods = "SHIFT",
				action = act.CopyMode("MoveToViewportTop"),
			},
			{
				key = "L",
				mods = "NONE",
				action = act.CopyMode("MoveToViewportBottom"),
			},
			{
				key = "L",
				mods = "SHIFT",
				action = act.CopyMode("MoveToViewportBottom"),
			},
			{
				key = "M",
				mods = "NONE",
				action = act.CopyMode("MoveToViewportMiddle"),
			},
			{
				key = "M",
				mods = "SHIFT",
				action = act.CopyMode("MoveToViewportMiddle"),
			},
			{
				key = "O",
				mods = "NONE",
				action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
			},
			{
				key = "O",
				mods = "SHIFT",
				action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
			},
			{
				key = "V",
				mods = "NONE",
				action = act.CopyMode({ SetSelectionMode = "Line" }),
			},
			{
				key = "V",
				mods = "SHIFT",
				action = act.CopyMode({ SetSelectionMode = "Line" }),
			},
			{
				key = "^",
				mods = "NONE",
				action = act.CopyMode("MoveToStartOfLineContent"),
			},
			{
				key = "^",
				mods = "SHIFT",
				action = act.CopyMode("MoveToStartOfLineContent"),
			},
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{
				key = "g",
				mods = "NONE",
				action = act.CopyMode("MoveToScrollbackTop"),
			},
			{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{
				key = "m",
				mods = "ALT",
				action = act.CopyMode("MoveToStartOfLineContent"),
			},
			{
				key = "o",
				mods = "NONE",
				action = act.CopyMode("MoveToSelectionOtherEnd"),
			},
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{
				key = "v",
				mods = "NONE",
				action = act.CopyMode({ SetSelectionMode = "Cell" }),
			},
			{
				key = "v",
				mods = "CTRL",
				action = act.CopyMode({ SetSelectionMode = "Block" }),
			},
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({
					{ CopyTo = "Clipboard" },
					{ CopyMode = "Close" },
					"PopKeyTable",
				}),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{
				key = "LeftArrow",
				mods = "ALT",
				action = act.CopyMode("MoveBackwardWord"),
			},
			{
				key = "RightArrow",
				mods = "NONE",
				action = act.CopyMode("MoveRight"),
			},
			{
				key = "RightArrow",
				mods = "ALT",
				action = act.CopyMode("MoveForwardWord"),
			},
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},
	},
	tab_bar_at_bottom = true,
	tab_max_width = 10,
	font_size = 14.0,
	show_tab_index_in_tab_bar = false,
	window_decorations = "RESIZE", -- TITLE/RESIZE
	window_close_confirmation = "NeverPrompt", -- NeverPrompt/AlawaysPrompt
	enable_scroll_bar = false,
	window_padding = {
		left = 16,
		right = 16,
		top = 16,
		bottom = 8,
	},
	window_frame = {
		font = wezterm.font({ family = "Roboto", weight = "Bold" }),
		font_size = 13.0,
		active_titlebar_bg = "#333333",
		inactive_titlebar_bg = "#333333",
	},
	colors = {
		tab_bar = {
			background = "#0b00ff",
			active_tab = {
				bg_color = "#453861",
				fg_color = "#fff",
				intensity = "Bold",
				underline = "None",
				italic = true,
				strikethrough = true,
			},
			inactive_tab_edge = "NONE",
			inactive_tab = {
				bg_color = "#1b1032",
				fg_color = "#808080",
			},
			inactive_tab_hover = {
				bg_color = "#251645",
				fg_color = "#909090",
			},
			new_tab = {
				bg_color = "#453861",
				fg_color = "#808080",
			},
			new_tab_hover = {
				bg_color = "#3b3052",
				fg_color = "#909090",
			},
		},
	},
	inactive_pane_hsb = {
		saturation = 0.5,
		brightness = 0.6,
	},
	default_prog = { fish_path() },
	skip_close_confirmation_for_processes_named = {},
}
