require('keymap')
require('settings')

local fn = vim.fn
local install_path = fn.stdpath "data" .. "/lazy/lazy.nvim"

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

require'lazy'.setup("plugins")
