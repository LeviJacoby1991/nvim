local status_ok, treeconfig = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
  return
end

treeconfig.setup{
  ensure_installed = {"c", "lua", "go", "rust", "cpp", "vim", "vimdoc", "graphql"},
  auto_install = true,
  sync_install=false,
  ignore_install={},
  highlight = {
    enable = true,
    disable = {"vimdoc"}
  },
  modules = {}
}
