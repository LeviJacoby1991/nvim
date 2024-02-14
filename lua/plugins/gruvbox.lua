return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = true,
  italic = {
    strings = false,
    comments = true,
  },
  config = function()
    vim.cmd('colorscheme gruvbox')
  end,
}
