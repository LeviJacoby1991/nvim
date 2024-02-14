return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine_status_ok, lualine = pcall(require, 'lualine')
    if not lualine_status_ok then
      print('lualine failed')
      return
    end
    lualine.setup{}
  end
}
