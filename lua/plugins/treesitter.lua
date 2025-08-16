return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ":TSUpdate",
  config = function ()
    require('nvim-treesitter.configs').setup({
      highlight = {enable = true, disable = {'vimdoc'}},
      ensure_installed = {'c', 'lua', 'go', 'rust', 'cpp', 'vim', 'vimdoc', 'graphql'},
      auto_install = false,
      sync_install = false,
    })
  end
}

