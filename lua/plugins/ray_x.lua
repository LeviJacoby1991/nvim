return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
  },
  lazy = true,
  goimport = 'gopls',
  gofmt = 'gofmt',
  ft = {'go', 'gomod'},
  lsp_gofumpt = false,
  config = function()
    local ray_x_status_ok, ray_x = pcall(require, 'go')
    if not ray_x_status_ok then
      print('ray_x failed')
      return
    end
    ray_x.setup()
    local format_sync_group = vim.api.nvim_create_augroup('GoFormat', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      callback = function()
        require 'go.format'.goimport()
      end,
      group = format_sync_group,
    })
  end
}
