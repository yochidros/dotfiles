local lsp_status = require("lsp-status")

local kind_labels_mt = {
	__index = function(_, k)
		return k
	end,
}
local kind_labels = {}
setmetatable(kind_labels, kind_labels_mt)
lsp_status.register_progress()

lsp_status.config({
	kind_labels = kind_labels,
})

vim.api.nvim_command([[
  function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      return luaeval("require('lsp-status').status()")
    endif
    return ''
  endfunction
]])
