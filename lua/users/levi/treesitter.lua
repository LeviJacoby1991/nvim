local status_ok, treeconfig = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
  return
end

treeconfig.setup{
  ensure_installed = {"c", "go", "rust", "cpp", "lua", "vim", "help", "graphql", "ruby"},
  highlight = {
    enable = true
  }
}
