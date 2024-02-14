return {
  'hrsh7th/nvim-cmp',
  lazy = true,
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
      },
      --lazy=false,
      version = 'v2.*.*',
      build = 'make install_jsregexp',
    },
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {
        disable_filetype = {'ruby', 'vim', 'TelescopePrompt'}
      }
    },
  },
  config = function()
    local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
    if not cmp_autopairs_status_ok then
      print('cmp autopairs failed')
      return
    end

    local cmp_status_ok, cmp = pcall(require, 'cmp')
    if not cmp_status_ok then
      print('cmp failed')
      return
    end

    local lua_status_ok, luasnip = pcall(require, 'luasnip')
    if not lua_status_ok then
      print('luasnip failed')
      return
    end

    local vsc_snippets_status_ok, vsc_snippets = pcall(require, 'luasnip.loaders.from_vscode')
    if not vsc_snippets_status_ok then
      print('snippets don\'t work ')
      return
    end

    vsc_snippets.lazy_load()

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs( -1),
        ['<C-f>'] = cmp.mapping.scroll_docs(1),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable( -1) then
            luasnip.jump( -1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      formatting = {},
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help'},
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    }
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end
}
