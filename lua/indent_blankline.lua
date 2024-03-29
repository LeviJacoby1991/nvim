local status_ok, indentLine = pcall(require, 'indent_blankline')

if not status_ok then
  return
end

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

--vim.opt.list = true


indentLine.setup({
  buftype_exclude = { 'terminal', 'nofile', 'NvimTree', 'wiki' },
  filetype_exclude = { 'help', 'packer', 'startify', 'NvimTree', 'alpha', 'wiki', 'md' },
  char_highlight_list = {
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
    "IndentBlanklineIndent7",
  },
})
