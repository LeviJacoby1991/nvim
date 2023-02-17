local status_ok, neodev = pcall(require, 'neodev')

if not status_ok then
  return
end

neodev.setup({
    library = {
    enabled = true,
    runtime = true,
    types = true,
    plugins = true,
  },
  setup_jsonls = true,
  override = function(root_dir, options) end,
  lspconfig = true,
  pathStrict = true,
})
