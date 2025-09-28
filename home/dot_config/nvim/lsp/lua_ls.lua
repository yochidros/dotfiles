return {
	cmd = { "lua-language-server", "--force-accept-workspace" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			hint = {
				enable = true,
			},
			format = {
				enable = false, -- Use StyLua
			},
			workspace = {
				ignoreDir = { "*" },
				checkThirdParty = false,
			},
			unusedLocalExclude = { "_*" },
		},
	},
}
