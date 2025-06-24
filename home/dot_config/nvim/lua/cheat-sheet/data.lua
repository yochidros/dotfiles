local M = {}

M.commands = {
	basic = {
		name = "Basic Commands",
		icon = "📝",
		commands = {
			{ key = "i", desc = "Enter insert mode" },
			{ key = "a", desc = "Enter insert mode after cursor" },
			{ key = "o", desc = "Open new line below" },
			{ key = "O", desc = "Open new line above" },
			{ key = "u", desc = "Undo" },
			{ key = "<C-r>", desc = "Redo" },
			{ key = "x", desc = "Delete character" },
			{ key = "dd", desc = "Delete line" },
			{ key = "yy", desc = "Yank (copy) line" },
			{ key = "p", desc = "Paste after cursor" },
			{ key = "P", desc = "Paste before cursor" },
			{ key = ":w", desc = "Save file" },
			{ key = ":q", desc = "Quit" },
			{ key = ":wq", desc = "Save and quit" },
		},
	},
	
	movement = {
		name = "Movement",
		icon = "🏃",
		commands = {
			{ key = "h/j/k/l", desc = "Move left/down/up/right" },
			{ key = "w", desc = "Move to next word" },
			{ key = "b", desc = "Move to previous word" },
			{ key = "e", desc = "Move to end of word" },
			{ key = "0", desc = "Move to beginning of line" },
			{ key = "$", desc = "Move to end of line" },
			{ key = "^", desc = "Move to first non-blank character" },
			{ key = "gg", desc = "Go to first line" },
			{ key = "G", desc = "Go to last line" },
			{ key = "{", desc = "Move to previous paragraph" },
			{ key = "}", desc = "Move to next paragraph" },
			{ key = "<C-u>", desc = "Scroll up half page" },
			{ key = "<C-d>", desc = "Scroll down half page" },
			{ key = "<C-b>", desc = "Scroll up full page" },
			{ key = "<C-f>", desc = "Scroll down full page" },
		},
	},
	
	editing = {
		name = "Editing",
		icon = "✏️",
		commands = {
			{ key = "r", desc = "Replace character" },
			{ key = "R", desc = "Replace mode" },
			{ key = "s", desc = "Substitute character" },
			{ key = "S", desc = "Substitute line" },
			{ key = "c", desc = "Change (with motion)" },
			{ key = "cc", desc = "Change line" },
			{ key = "C", desc = "Change to end of line" },
			{ key = "d", desc = "Delete (with motion)" },
			{ key = "D", desc = "Delete to end of line" },
			{ key = "y", desc = "Yank (with motion)" },
			{ key = "Y", desc = "Yank line" },
			{ key = ">>", desc = "Indent line" },
			{ key = "<<", desc = "Unindent line" },
			{ key = "=", desc = "Auto-indent (with motion)" },
			{ key = "J", desc = "Join lines" },
		},
	},
	
	visual = {
		name = "Visual Mode",
		icon = "👁️",
		commands = {
			{ key = "v", desc = "Visual mode" },
			{ key = "V", desc = "Visual line mode" },
			{ key = "<C-v>", desc = "Visual block mode" },
			{ key = "o", desc = "Move to other end of selection" },
			{ key = "gv", desc = "Re-select last selection" },
			{ key = "d", desc = "Delete selection" },
			{ key = "y", desc = "Yank selection" },
			{ key = "c", desc = "Change selection" },
			{ key = ">", desc = "Indent selection" },
			{ key = "<", desc = "Unindent selection" },
			{ key = "=", desc = "Auto-indent selection" },
		},
	},
	
	search = {
		name = "Search & Replace",
		icon = "🔍",
		commands = {
			{ key = "/", desc = "Search forward" },
			{ key = "?", desc = "Search backward" },
			{ key = "n", desc = "Next search result" },
			{ key = "N", desc = "Previous search result" },
			{ key = "*", desc = "Search word under cursor" },
			{ key = "#", desc = "Search word under cursor backward" },
			{ key = ":s/old/new/", desc = "Replace in line" },
			{ key = ":%s/old/new/g", desc = "Replace in file" },
			{ key = ":noh", desc = "Clear search highlight" },
		},
	},
	
	buffers = {
		name = "Buffers",
		icon = "📄",
		commands = {
			{ key = ":e file", desc = "Edit file" },
			{ key = ":bn", desc = "Next buffer" },
			{ key = ":bp", desc = "Previous buffer" },
			{ key = ":bd", desc = "Delete buffer" },
			{ key = ":ls", desc = "List buffers" },
			{ key = ":b#", desc = "Switch to alternate buffer" },
			{ key = "<C-^>", desc = "Switch to alternate buffer" },
		},
	},
	
	windows = {
		name = "Windows",
		icon = "🪟",
		commands = {
			{ key = ":sp", desc = "Split horizontally" },
			{ key = ":vsp", desc = "Split vertically" },
			{ key = "<C-w>h/j/k/l", desc = "Move between windows" },
			{ key = "<C-w>w", desc = "Cycle through windows" },
			{ key = "<C-w>q", desc = "Close window" },
			{ key = "<C-w>=", desc = "Equalize window sizes" },
			{ key = "<C-w>_", desc = "Maximize height" },
			{ key = "<C-w>|", desc = "Maximize width" },
			{ key = "<C-w>+", desc = "Increase height" },
			{ key = "<C-w>-", desc = "Decrease height" },
		},
	},
	
	git = {
		name = "Git (Fugitive)",
		icon = "🔧",
		commands = {
			{ key = ":G", desc = "Git status" },
			{ key = ":Gcommit", desc = "Git commit" },
			{ key = ":Gpush", desc = "Git push" },
			{ key = ":Gpull", desc = "Git pull" },
			{ key = ":Gdiff", desc = "Git diff" },
			{ key = ":Gblame", desc = "Git blame" },
			{ key = ":Glog", desc = "Git log" },
		},
	},
	
	lsp = {
		name = "LSP",
		icon = "🔧",
		commands = {
			{ key = "gd", desc = "Go to definition" },
			{ key = "gD", desc = "Go to declaration" },
			{ key = "gr", desc = "Go to references" },
			{ key = "gi", desc = "Go to implementation" },
			{ key = "K", desc = "Show hover" },
			{ key = "<C-k>", desc = "Show signature help" },
			{ key = "<leader>rn", desc = "Rename" },
			{ key = "<leader>ca", desc = "Code action" },
			{ key = "[d", desc = "Previous diagnostic" },
			{ key = "]d", desc = "Next diagnostic" },
			{ key = "<leader>f", desc = "Format document" },
		},
	},
	
	telescope = {
		name = "Telescope",
		icon = "🔭",
		commands = {
			{ key = "<leader>ff", desc = "Find files" },
			{ key = "<leader>fg", desc = "Live grep" },
			{ key = "<leader>fb", desc = "Buffers" },
			{ key = "<leader>fh", desc = "Help tags" },
			{ key = "<leader>fc", desc = "Commands" },
			{ key = "<leader>fr", desc = "Recent files" },
			{ key = "<leader>fs", desc = "Grep string" },
			{ key = "<C-g>", desc = "Git files" },
		},
	},
	
	folding = {
		name = "Folding",
		icon = "📁",
		commands = {
			{ key = "za", desc = "Toggle fold" },
			{ key = "zo", desc = "Open fold" },
			{ key = "zc", desc = "Close fold" },
			{ key = "zR", desc = "Open all folds" },
			{ key = "zM", desc = "Close all folds" },
			{ key = "zj", desc = "Move to next fold" },
			{ key = "zk", desc = "Move to previous fold" },
		},
	},
	
	marks = {
		name = "Marks",
		icon = "📍",
		commands = {
			{ key = "ma", desc = "Set mark a" },
			{ key = "'a", desc = "Jump to mark a" },
			{ key = "''", desc = "Jump to previous position" },
			{ key = ":marks", desc = "List marks" },
		},
	},
	
	macros = {
		name = "Macros",
		icon = "🎬",
		commands = {
			{ key = "qa", desc = "Record macro a" },
			{ key = "q", desc = "Stop recording" },
			{ key = "@a", desc = "Play macro a" },
			{ key = "@@", desc = "Repeat last macro" },
		},
	},
	
	terminal = {
		name = "Terminal",
		icon = "💻",
		commands = {
			{ key = ":term", desc = "Open terminal" },
			{ key = "<C-\\><C-n>", desc = "Exit terminal mode" },
		},
	},
}

M.get_contextual_commands = function()
	local filetype = vim.bo.filetype
	local mode = vim.fn.mode()
	
	local contextual = {}
	
	if filetype == "rust" then
		contextual.rust = {
			name = "Rust",
			icon = "🦀",
			commands = {
				{ key = "<leader>rc", desc = "Cargo check" },
				{ key = "<leader>rr", desc = "Cargo run" },
				{ key = "<leader>rt", desc = "Cargo test" },
				{ key = "<leader>rb", desc = "Cargo build" },
			},
		}
	elseif filetype == "swift" then
		contextual.swift = {
			name = "Swift",
			icon = "🍎",
			commands = {
				{ key = "<leader>xb", desc = "Xcode build" },
				{ key = "<leader>xr", desc = "Xcode run" },
				{ key = "<leader>xt", desc = "Xcode test" },
			},
		}
	elseif filetype == "go" then
		contextual.go = {
			name = "Go",
			icon = "🐹",
			commands = {
				{ key = "<leader>gr", desc = "Go run" },
				{ key = "<leader>gt", desc = "Go test" },
				{ key = "<leader>gb", desc = "Go build" },
			},
		}
	end
	
	return contextual
end

return M