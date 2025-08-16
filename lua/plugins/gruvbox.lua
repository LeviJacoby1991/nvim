return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  italic = {
    strings = false,
    comments = true,
  },
  config = function()
    vim.cmd('colorscheme gruvbox')
  end,
}
