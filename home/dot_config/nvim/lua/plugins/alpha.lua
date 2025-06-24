local M = {
	"goolord/alpha-nvim",
	lazy = false,
	priority = 5,
}

function M.config()
	local status, alpha = pcall(require, "alpha")
	if not status then
		return
	end

	local logo = {
		[[                                  __]],
		[[     ___     ___    ___   __  __ /\_\    ___ ___]],
		[[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
		[[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
		[[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}
	local dashboard = require("alpha.themes.dashboard")

	math.randomseed(os.time())
	-- local keys = #vim.tbl_keys(banners_index)
	dashboard.section.header.val = logo -- banners[banners_index[math.random(1, keys)]]
	dashboard.section.buttons.val = {
		dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("<Leader>ff", "  File Explorer"),
		dashboard.button("<Leader>fh", "  Find File"),
		dashboard.button("<Leader>fr", "  Find Word"),
		dashboard.button("<Leader>fm", "  Jump to bookmarks"),
		dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
	}

	dashboard.section.buttons.opts.spacing = 0
	local function footer()
		-- local total_plugins = #vim.tbl_keys(vim.g.plugs)
		local version = vim.version()
		local nvim_version_info = " Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch

		return nvim_version_info
	end

	dashboard.section.footer.val = footer()

	dashboard.config.opts.margin = 10
	dashboard.config.opts.noautocmd = true
	dashboard.config.layout = {
		{ type = "padding", val = 1 },
		dashboard.section.header,
		{ type = "padding", val = 1 },
		dashboard.section.buttons,
		{ type = "padding", val = 2 },
		dashboard.section.footer,
	}

	alpha.setup(dashboard.config)
end
return M
