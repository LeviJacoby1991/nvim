return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  auto_install = false,
  sync_install = false,
  ignore_install={},
  --highlight = {
  --  enable = true,
  --  --disable = {'vimdoc'}
  --},
  modules = {},
  config = function()
    local configs = require 'nvim-treesitter.configs'
    configs.setup {
      ensure_installed = {'c', 'lua', 'go', 'rust', 'cpp', 'vim', 'vimdoc', 'graphql'},
      highlight = {
        enable = true
      },
    }
  end
}

