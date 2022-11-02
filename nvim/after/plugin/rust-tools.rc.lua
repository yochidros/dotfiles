-- Rust Tools
local rt = require('rust-tools')
rt.setup({
  tools = {
    reload_workspace_from_cargo_toml = false
  },
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    standalone = true,
  }
})
