local fn = vim.fn
local install_path = fn.stdpath "data" .. "/lazy/lazy.nvim"
print(install_path)

if not vim.loop.fs_stat(install_path) then
  fn.system ({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    install_path,
  })
  print "Installing lazy.nvim close and reopen Neovim..."
end

vim.opt.rtp:prepend(install_path)

local lz = require'lazy'

return lz.setup(
  plugins,
  --'hrsh7th/nvim-cmp' ,
  --'hrsh7th/cmp-nvim-lsp',
  --'hrsh7th/cmp-buffer',
  --'hrsh7th/cmp-path',
  --'hrsh7th/cmp-cmdline',
  --'saadparwaiz1/cmp_luasnip',
  --{ 'L3MON4D3/LuaSnip', version = 'v2.*.*', run = 'make install_jsregexp' },
  --'vimwiki/vimwiki',
  --'ellisonleao/gruvbox.nvim',
  --'rafamadriz/friendly-snippets',
  --{
  --  'nvim-telescope/telescope.nvim',
  --  tag = '0.1.5',
  --  dependencies = { 'nvim-lua/plenary.nvim' }
  --},
  --{ 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }, },
  --'nvim-treesitter/nvim-treesitter',
  --{ 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' },
  --{ 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' }, },
  --'ray-x/go.nvim' ,
  --'ray-x/guihua.lua',
  --'folke/neodev.nvim',
  --'theHamsta/nvim-dap-virtual-text',
  --'akinsho/toggleterm.nvim',
  --{ 'windwp/nvim-autopairs',
  --  event = "InsertEnter",
  --  opts = {
  --    disable_filetype = {'ruby', 'vim', 'TelescopePrompt'},
  --  }
  --},
  --'lukas-reineke/indent-blankline.nvim',
  --'skanehira/preview-uml.vim',
  --'ellisonleao/dotenv.nvim' ,
)
