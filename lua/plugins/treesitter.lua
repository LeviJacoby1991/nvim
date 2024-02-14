return {
  'nvim-treesitter/nvim-treesitter',
  ensure_installed = {'c', 'lua', 'go', 'rust', 'cpp', 'vim', 'vimdoc', 'graphql'},
  auto_install = true,
  sync_install=false,
  ignore_install={},
  highlight = {
    enable = true,
    disable = {'vimdoc'}
  },
  modules = {}
}
