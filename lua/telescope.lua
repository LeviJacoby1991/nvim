local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
  return
end

local actions = require'telescope.actions'
local builtin = require'telescope.builtin'

local function map(mode, lhs, rhs, opt)
  local t = {':Telescope ', '<cr>'}
  if rhs then
    table.insert(t, 2, rhs)
  end
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend("force", options, opt)
  end
  vim.keymap.set(mode, lhs, table.concat(t), options)
end

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<Esc>"] = "close"
      },
      n = {
        ["hl"] = "close"
      }
    },
  },
  pickers = {
  }
}

map('n', '<leader>ft')
map('n', '<leader>ff', 'find_files')
map('n', '<leader>fb', 'buffers')
map('n', '<leader>fd', 'diagnostics')
map('n', '<leader>fs', 'treesitter')
