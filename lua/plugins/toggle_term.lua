function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'qt', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function ()
    local term = require'toggleterm.terminal'.Terminal
    local lazygit = term:new({
      cmd = 'lazygit',
      direction = 'float',
      float_opts = { border = 'curved' },
      hidden = true,
    })
    local short_cut_term = term:new({
      direction = 'horizontal',
      hidden = true,
      size = 25,
      hide_numbers = true,
      close_on_exit = true,
    })

    function Lazygit_Toggle()
      lazygit:toggle()
    end

    function Short_Cut_Term_Toggle()
      short_cut_term:toggle()
    end
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua Lazygit_Toggle()<CR>', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader><S-T>', '<cmd>lua Short_Cut_Term_Toggle()<CR>', { noremap = true, silent = true})
  end
}
