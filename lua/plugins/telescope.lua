local function map(mode, lhs, rhs, opt)
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend('force', options, opt)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  defaults = {
    mappings = {
      i = {
        ['<C-h>'] = 'which_key',
        ['<Esc>'] = 'close'
      },
      n = {
        ['<C-m>'] = 'close'
      }
    },
  },
  pickers = {
  },
  config = function()
    local actions = require'telescope.actions'
    local builtin = require'telescope.builtin'
    vim.keymap.set('n', '<leader>ft', ':Telescope <cr>')
    map('n', '<leader>ff', builtin.find_files)
    map('n', '<leader>fb', builtin.buffers)
    map('n', '<leader>fd', builtin.diagnostics)
    map('n', '<leader>fr', builtin.lsp_references)
    map('n', '<leader>fs', builtin.treesitter)
  end,
}
