local status_ok, toggle_term = pcall(require, 'toggleterm')

if not status_ok then
  return
end

toggle_term.setup{}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'qt', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

local toggleterm = require'toggleterm.terminal'.Terminal

local lazygit = toggleterm:new({cmd = 'lazygit',
  direction = 'float',
  float_opts = { border = 'curved' },
  hidden = true,
})

local shortCutTerm = toggleterm:new({
  direction = 'horizontal',
  hidden = true,
  size = 20,
  hide_numbers = true,
  close_on_exit = true,
})

function Lazygit_toggle()
  lazygit:toggle()
end

function ShortCutTerm_toggle()
  shortCutTerm:toggle()
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua Lazygit_toggle()<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><S-T>', '<cmd>lua ShortCutTerm_toggle()<CR>', { noremap = true, silent = true})
