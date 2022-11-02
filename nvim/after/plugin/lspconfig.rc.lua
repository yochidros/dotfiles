-- LSP

local lsp_status = require('lsp-status')
local nvim_lsp = require('lspconfig')

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require("lsp_signature").on_attach({}, bufnr)
  lsp_status.on_attach(client)

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

-- rust-analyzer

nvim_lsp.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
  flags = lsp_flags,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      diagnostic = {
        disabled = { "missing-unsafe" }
      },
      procMacro = {
        enable = true
      },
      server = {
        path = { "~/.local/share/nvim/lsp_servers/rust/rust-analyzer" }
      }
    },
  }
})

-- swift
nvim_lsp.sourcekit.setup({
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
  flags = lsp_flags,
  root_dir = function()
    return vim.fn.getcwd()
  end
})

nvim_lsp.solargraph.setup({
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
  flags = lsp_flags,
  cmd = { "/Users/miyazawayoshiki/.rbenv/shims/solargraph", "stdio" },
  init_options = {
    formatting = true
  },
  settings = {
    solargraph = {
      commandPath = "/Users/miyazawayoshiki/.rbenv/shims/solargraph",
      diagnostics = true,
      useBundler = true,
      bundlerPath = "/Users/miyazawayoshiki/.rbenv/shims/bundler"
    }
  }
})


local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }

}
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
}
print('hoge')
nvim_lsp.hls.sertup {
  on_attach = on_attach,
  cmd = { '/home/yochidros/.ghcup/bin/haskell-language-server-9.0.2~1.7.0.0', '--lsp'},
  flags = lsp_flags,
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
}


local servers = { 'pyright', 'gopls', 'kotlin_language_server', 'eslint' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  })
end
