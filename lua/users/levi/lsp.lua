local servers = { 'gopls', 'clangd', 'rust_analyzer', 'lua_ls', 'graphql' }

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
}

local capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())
local mason = require 'mason'
local mason_lsp_config = require 'mason-lspconfig'
local lsp = require 'lspconfig'

mason.setup()
mason_lsp_config.setup({
  automatic_installation = true,
})

local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true, buffer = bufnr }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
  end
  map('n', 'K', vim.lsp.buf.hover)
  map('n', ']d', vim.diagnostic.goto_next)
  map('n', '[d', vim.diagnostic.goto_prev)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gr', vim.lsp.buf.references)
  map('n', ',rn', vim.lsp.buf.rename)
  map('n', ',ac', vim.lsp.buf.code_action)
  map('n', ',f', function()
    vim.lsp.buf.format { async = true }
  end)
end


for _, name in ipairs(servers) do
  lsp[name].setup {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities
  }
end
