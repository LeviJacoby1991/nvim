local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  print("Works")
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd[[packadd packer.nvim]]
end

local group = vim.api.nvim_create_augroup("packer_user_config", {clear = true})
vim.api.nvim_create_autocmd("BufWritePost", {pattern = "plugins.lua", command = "source <afile> | PackerSync", group = group})

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end
  }
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"
  use "vimwiki/vimwiki"
  use "ellisonleao/gruvbox.nvim"
  use "rafamadriz/friendly-snippets"
  use { "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { "nvim-lua/plenary.nvim" } }
  use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }
  use "nvim-treesitter/nvim-treesitter"
  use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" }
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use { "ray-x/go.nvim" }
  use { "ray-x/guihua.lua" }
  use { "folke/neodev.nvim" }
  use { "theHamsta/nvim-dap-virtual-text" }
  use { "akinsho/toggleterm.nvim" }
  use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }
end)
