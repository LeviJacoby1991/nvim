local status_ok, go = pcall(require, 'go')

if not status_ok then
  return
end

go.setup()

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
    require('go.format').gofmt()
  end,
  group = format_sync_grp
})
