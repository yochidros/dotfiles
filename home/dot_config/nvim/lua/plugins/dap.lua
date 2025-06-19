local M = {
	"mfussenegger/nvim-dap",
	cmd = "LLDBStart",
	config = function()
		local dap = require("dap")
		dap.configurations.rust = {
			{
				name = "Debug",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = function()
					return { vim.fn.input("args: ", "", "file") }
				end,
			},
		}

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = os.getenv("HOME") .. "/Documents/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}
		vim.g.rustaceanvim = function()
			local extension_path = vim.env.HOME .. "/Documents/codelldb/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb"
			liblldb_path = liblldb_path .. ".dylib"
			local cfg = require("rustaceanvim.config")
			return {
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end

		-- nice breakpoint icons
		local define = vim.fn.sign_define
		define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
		define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
		define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
		define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

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

			local success, dapui = pcall(require, "dapui")
			if success then
				dapui.close()
			end
		end)
	end,
}

return M
