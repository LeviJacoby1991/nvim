local autopairs_status_ok, autopairs = pcall(require, 'nvim-autopairs')

if not autopairs_status_ok then
  return
end

local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

if not cmp_autopairs_status_ok then
  return
end

local cmp_status_ok, cmp = pcall(require, 'cmp')

if not cmp_status_ok then
  return
end

local lua_status_ok, luasnip = pcall(require, 'luasnip')

if not lua_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.completeopt = { 'menuone', 'noselect', 'noinsert' }

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete({ config = { sources = { name = 'nvim_lsp' }, { name = 'luasnip' }, {name = 'buffer'}, { name = 'path' } } }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm( { select = false } ),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }) ,
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"}),
  },
  formatting = {
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completetion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

cmp.event:on(
  'confirm',
   cmp_autopairs.on_confirm_done()
)

