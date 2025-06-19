local M = {
	"wojciech-kulik/xcodebuild.nvim",
	cmd = { "XcodebuildRun", "XcodebuildBuild" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("dapui").setup({
					controls = {
						element = "repl",
						enabled = true,
					},
					floating = {
						border = "single",
						mappings = {
							close = { "q", "<Esc>" },
						},
					},
					icons = { collapsed = "", expanded = "", current_frame = "" },
					layouts = {
						{
							elements = {
								{ id = "stacks", size = 0.25 },
								{ id = "scopes", size = 0.25 },
								{ id = "breakpoints", size = 0.25 },
								{ id = "watches", size = 0.25 },
							},
							position = "left",
							size = 60,
						},
						{
							elements = {
								{ id = "repl", size = 1.0 },
								{ id = "console", size = 0.3 },
							},
							position = "bottom",
							size = 10,
						},
					},
				})

				local dap, dapui = require("dap"), require("dapui")
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end
			end,
			dependencies = {
				{
					"mfussenegger/nvim-dap",
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
									string.gsub(lldb_path, "LLDB\n", "")
										.. "../../../SharedFrameworks/LLDB.framework/Versions/A/LLDB",
								},
							},
						}

						-- nice breakpoint icons
						local define = vim.fn.sign_define
						define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
						define(
							"DapBreakpointRejected",
							{ text = "", texthl = "DiagnosticError", linehl = "", numhl = "" }
						)
						define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
						define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
						define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

						-- integration with xcodebuild.nvim
						vim.keymap.set("n", "<leader>dd", function()
							dap.terminate()
							xcodebuild.build_and_debug()
						end, { desc = "Build & Debug" })
						vim.keymap.set(
							"n",
							"<leader>dr",
							xcodebuild.debug_without_build,
							{ desc = "Debug Without Building" }
						)

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
				},
				"nvim-neotest/nvim-nio",
			},
		},
	},
}
function M.config()
	require("xcodebuild").setup({})
	vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildRun<cr>", { desc = "Run Project" })
	vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
end

return M
