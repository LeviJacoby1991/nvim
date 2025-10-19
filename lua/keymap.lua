local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '
map('n', '<space>', '<Nop>')
map('i', 'jj', '<Esc>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')
map('n', '<leader>nvcc', ':source %<cr>')
map('n', '<leader><S-Q>', ':q!<cr>')

vim.api.nvim_create_autocmd('Filetype', {
  pattern = {'qf'},
  callback = function ()
    vim.keymap.set('n', 'q', '<cmd>cclose<cr>', {silent = true, buffer = true})
  end
})
