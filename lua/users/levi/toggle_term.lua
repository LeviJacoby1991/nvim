toggle_term = require("toggleterm")

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'qt', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

local terminal = require('toggleterm.terminal').Terminal
local lazygit = terminal:new({cmd = "lazygit", 
  direction = "float", 
  float_opts = { border = "double" }, 
  hidden = true,
})
local shortCutTerm = terminal:new({
  direction = "horizontal",
  hidden = true,
  size = 20,
  hide_numbers = true,
  close_on_exit = true,
})

function _lazygit_toggle()
  lazygit:toggle()
end

function _shortCutTerm_toggle()
  shortCutTerm:toggle()
end

toggle_term.setup{}

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader><S-T>", "<cmd>lua _shortCutTerm_toggle()<CR>", { noremap = true, silent = true})
