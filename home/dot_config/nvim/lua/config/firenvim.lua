if not vim.g.started_by_firenvim then
	return
end

local width = vim.fn.system(
	"system_profiler SPDisplaysDataType | grep Resolution | head -n 1 | sed  -e 's/.*Resolution://' -e 's/\\ //g' -e 's/Retina//' -e 's/(.*$//g' | cut -d'x' -f1"
)

local height = vim.fn.system(
	"system_profiler SPDisplaysDataType | grep Resolution | head -n 1 | sed  -e 's/.*Resolution://' -e 's/\\ //g' -e 's/Retina//' -e 's/(.*$//g' | cut -d'x' -f2"
)

if tonumber(width) >= 2580 and tonumber(height) >= 1800 then
	vim.o.guifont = "Hack:h14"
elseif tonumber(width) >= 1980 and tonumber(height) >= 1080 then
	vim.o.guifont = "Hack:h12"
else
	vim.o.guifont = "Hack:h8"
end

vim.api.nvim_exec("language en_US", true)

function adjust_font_size(amount)
	local fontsize = vim.g.fontsize + amount
	vim.g.fontsize = fontsize
	vim.o.guifont = "Hack:h" .. fontsize
	vim.api.nvim_exec('call rpcnotify(0, "Gui", "WindowMaximized", 1)', false)
end

local function setup_dynamic_font_adjst()
	if vim.g.started_by_firenvim then
		vim.api.nvim_set_keymap("n", "<space>", ":set lines=13 columns=100<CR>", { noremap = true })

		vim.g.fontsize = 14

		vim.api.nvim_set_keymap("n", "<C-=>", ":lua adjust_font_size(1)<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-->", ":lua adjust_font_size(-1)<CR>", { noremap = true, silent = true })
	end
end

setup_dynamic_font_adjst()

vim.g.firenvim_config.localSettings[".*"] = { cmdline = "neovim" }
vim.g.firenvim_config.localSettings["https?://bit-key.atlassian.net/"] = { takeover = "never", priority = 1 }
vim.g.firenvim_config = {
	globalSettings = {
		all = { "<C-->" },
	},
	localSettings = {
		[".*"] = {
			cmdline = "neovim",
			takeover = "never",
		},
		["https?://bit-key.atlassian.net/"] = {
			takeover = "never",
			priority = 1,
		},
	},
}

vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>wq<CR>", {})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "github.com_*.txt",
	callback = function()
		vim.cmd("set filetype=markdown")
	end,
})

vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		vim.fn.timer_start(500, function()
			vim.opt.lines = 20
		end)
	end,
})
-- vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})
-- vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>call firenvim#hide_frame()<CR>", {})
-- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
-- 	nested = true,
-- 	command = "write",
-- })
