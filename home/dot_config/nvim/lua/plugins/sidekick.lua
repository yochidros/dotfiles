local M = {
	"folke/sidekick.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
		nes = {
			trigger = {
				-- events that trigger sidekick next edit suggestions
				events = { "ModeChanged i:n", "TextChanged", "User SidekickNesDone", "User SidekickNesManual" },
			},
		},
		cli = {
			mux = {
				backend = "zellij",
				enabled = false,
			},
		},
	},
  -- stylua: ignore
  keys = {
    {
      "<tab>",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          require("sidekick.nes").update()
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      mode = { "n", "v" },
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select({ filter = { installed = true } }) end,
      desc = "Sidekick Select CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").send({ selection = true, filter = { installed = true } }) end,
      mode = { "v" },
      desc = "Sidekick Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "v" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").focus() end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    {
      "<leader>ac",
      function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end,
      desc = "Sidekick Codex Toggle",
      mode = { "n", "v" },
    },
  },
}

function M.config()
	require("sidekick").setup(M.opts)
	local _nes = require("sidekick.nes")
	local orig_update = _nes.update
	local handle

	---@diagnostic disable-next-line: duplicate-set-field
	_nes.update = function()
		orig_update()

		local buf = vim.api.nvim_get_current_buf()
		if not require("sidekick.config").get_client(buf) then
			return
		end

		if handle ~= nil then
			return
		end

		local status, progress = pcall(require, "fidget.progress")
		if not status then
			return
		end
		handle = progress.handle.create({
			message = "Updating nes suggestion ...",
			lsp_client = { name = "  copilot nes" },
		})
	end

	local orig_handler = _nes._handler

	---@diagnostic disable-next-line: duplicate-set-field
	_nes._handler = function(err, result, ctx)
		local ret = orig_handler(err, result, ctx)
		vim.schedule(function()
			if not handle then
				return
			end

			handle._raw.message = ""
			handle:finish({
				---@diagnostic disable-next-line: undefined-global
				message = message,
			})
			handle = nil
		end)
		return ret
	end
end

return M
