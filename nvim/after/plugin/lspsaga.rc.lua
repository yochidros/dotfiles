local lspsaga = require('lspsaga')

lspsaga.init_lsp_saga({
  border_style = "rounded",
})

-- lsp finder to find the cursor word definition and reference
vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, { silent = true, noremap = true })

local action = require("lspsaga.codeaction")

-- code action

vim.keymap.set("n", "<leader>ca", action.code_action, { silent = true, noremap = true })
vim.keymap.set("v", "<leader>ca", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  action.range_code_action()
end, { silent = true, noremap = true })

-- hover dock
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Outline
vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
-- rename
vim.keymap.set("n", "gR", "<cmd>Lspsaga rename<CR>", { silent = true })
-- close rename win use <C-c> in insert mode or `q` in normal mode or `:q`

-- local action = require("lspsaga.action")
-- -- scroll down hover doc or scroll in definition preview
-- vim.keymap.set("n", "<C-f>", function()
--   action.smart_scroll_with_saga(1)
-- end, { silent = true })
--
-- -- scroll up hover doc
-- vim.keymap.set("n", "<C-b>", function()
--   action.smart_scroll_with_saga(-1)
-- end, { silent = true })

-- show signature help
-- vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, { silent = true,noremap = true})

-- preview definition
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
-- Show line diagnostics
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- or jump to error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, noremap = true })
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, noremap = true })

-- float terminal also you can pass the cli command in open_float_terminal function
vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })

vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
-- vim.keymap.set("t", "<A-d>", function()
--   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true))
--   term.close_float_terminal()
-- end, { silent = true })
