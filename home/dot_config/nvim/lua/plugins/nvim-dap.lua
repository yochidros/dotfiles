local M = {
	"mfussenegger/nvim-dap",
	ft = "swift",
	cmd = "Xcodebuild",
	enabled = false,
	dependencies = {
		"wojciech-kulik/xcodebuild.nvim",
	},
	config = function()
		local dap = require("dap")
		local xcodebuild = require("xcodebuild.dap")

		dap.configurations.swift = {
			{
				name = "iOS App Debugger",
				type = "codelldb",
				request = "attach",
				program = xcodebuild.get_program_path,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				waitFor = true,
			},
		}

		local lldb_path = vim.fn.system("xcrun -f LLDB")
		dap.adapters.codelldb = {
			type = "server",
			port = "13000",
			executable = {
				command = os.getenv("HOME") .. "/Documents/codelldb/extension/adapter/codelldb",
				args = {
					"--port",
					"13000",
					"--liblldb",
					string.gsub(lldb_path, "LLDB\n", "") .. "../../../SharedFrameworks/LLDB.framework/Versions/A/LLDB",
				},
			},
		}

		-- nice breakpoint icons
		local define = vim.fn.sign_define
		define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
		define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
		define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

		-- integration with xcodebuild.nvim
		vim.keymap.set("n", "<leader>dd", function()
			dap.terminate()
			xcodebuild.build_and_debug()
		end, { desc = "Build & Debug" })
		vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })

		vim.keymap.set("n", "<leader>dt", dap.terminate)
		vim.keymap.set("n", "<leader>dc", dap.continue)
		vim.keymap.set("n", "<leader>ds", dap.step_over)
		vim.keymap.set("n", "<leader>di", dap.step_into)
		vim.keymap.set("n", "<leader>do", dap.step_out)
		vim.keymap.set("n", "<leader>bt", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>bc", dap.clear_breakpoints)
		vim.keymap.set("n", "<leader>bs", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end)
		vim.keymap.set("n", "<Leader>dx", function()
			dap.terminate()
			require("xcodebuild.actions").cancel()

			local success, dapui = pcall(require, "dapui")
			if success then
				dapui.close()
			end
		end)
	end,
}
return M
