local set = vim.opt
set.number = true
set.expandtab = true
set.smarttab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.showmatch = true
set.splitright = true
set.swapfile = false
set.termguicolors = true


local nt = vim.api.nvim_create_augroup("numbertoggle", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {command = "set relativenumber", group = nt})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {command = "set norelativenumber", group = nt})

local termNums = vim.api.nvim_create_augroup("toggleTerm", {clear = true})
vim.api.nvim_create_autocmd({"TermEnter", "FocusLost", "InsertEnter"}, {command = "set norelativenumber", group = termNums})
