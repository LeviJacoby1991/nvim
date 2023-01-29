treeconfig = require'nvim-treesitter.configs'

treeconfig.setup{
  ensure_installed = {"c", "lua", "go", "rust", "cpp", "vim", "help"},
  highlight = {
    enable = true
  }
}
