require'lspconfig'.clangd.setup{
  vim.diagnostic.disable()
}

require'lspconfig'.html.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.eslint.setup{}
