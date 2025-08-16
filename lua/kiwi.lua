return {
  'serenevoid/kiwi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    {
      name = "personal",
      path = "~/wiki"
    },
    {
      name = "work",
      path = "~/documents/wiki"
    }
  },
  keys = {
    {"<leader>ww", ":lua require(\"kiwi\").open_wiki_index(\"personal\")<cr>", desc = "Open personal wiki index"},
    {"<leader>ww", ":lua require(\"kiwi\").open_wiki_index(\"work\")<cr>", desc = "Open personal wiki index"},
    {"T", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task"}
  },
}
