local status_ok, treeconfig = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
  return
end

treeconfig.setup{
  ensure_installed = {"c", "lua", "go", "rust", "cpp", "vim", "help", "graphql"},
  highlight = {
    enable = true
  }
}
