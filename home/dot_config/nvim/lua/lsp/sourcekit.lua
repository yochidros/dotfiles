return {
	root_dir = function(filename, _)
		local util = vim.lsp.util
		local root = util.root_pattern("buildServer.json")(filename)
			or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
			or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
			or util.root_pattern("Package.swift")(filename)
		if root then
			return root
		else
			return vim.fn.getcwd()
		end
	end,
	filetypes = { "swift", "objc", "objcpp" },
	cmd = { "sourcekit-lsp" },
}
