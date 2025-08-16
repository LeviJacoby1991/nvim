return {
  'neovim/nvim-lspconfig',
  config = function()
    local servers = { 'gopls', 'clangd', 'rust_analyzer', 'solargraph', 'lua_ls', 'graphql', 'ts_ls', 'buf_ls', 'pyright'}
    --local handlers = { ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }) }
    --local handlers = { ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }) }
    --vim.lsp.hover('rounded')

    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require 'cmp_nvim_lsp'.default_capabilities()
    )

    local mason_status_ok, mason = pcall(require, 'mason')
    if not mason_status_ok then
      print('mason failed')
      return
    end

    local mason_lsp_status_ok, mason_lsp_config = pcall(require, 'mason-lspconfig')
    if not mason_lsp_status_ok then
      print('mason-lspconfig failed')
      return
    end

    local lsp_status_ok, lsp = pcall(require, 'lspconfig')
    if not lsp_status_ok then
      print('lspconfig failed')
      return
    end

    mason.setup()
    mason_lsp_config.setup({
      automatic_installation = true,
      ensure_installed = servers,
      automatic_enable = false,
    })

    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, opts)
        local options = {noremap = true, silent = true, buffer = bufnr}
        if opts then
          options = vim.tbl_extend('force', options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
      end
      map('n', 'K', vim.lsp.buf.hover)
      map('n', ']d', vim.diagnostic.goto_next)
      map('n', '[d', vim.diagnostic.goto_prev)
      map('n', 'gd', vim.lsp.buf.definition)
      map('n', 'gD', vim.lsp.buf.declaration)
      map('n', 'gr', vim.lsp.buf.references)
      map('n', ',rn', vim.lsp.buf.rename)
      map('n', ',ac', vim.lsp.buf.code_action)
      map('n', ',f', function()
        vim.lsp.buf.format { async = true }
      end)
    end

    for _, name in ipairs(servers) do
      lsp[name].setup {
        on_attach = on_attach,
        --handlers = handlers,
        capabilities = capabilities,
      }
    end

    -- GODOT
    -- paths to check for project.godot file
    local paths_to_check = {'/', '/../'}
    local is_godot_project = false
    local godot_project_path = ''
    local cwd = vim.fn.getcwd()

    -- iterate over paths and check
    for key, value in pairs(paths_to_check) do
      if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
          is_godot_project = true
          godot_project_path = cwd .. value
          break
      end
    end

    -- check if server is already running in godot project path
    local is_godot_server_running = vim.uv.fs_stat(godot_project_path .. '/server.pipe')
    -- start server, if not already running
    if is_godot_project and not is_godot_server_running then
      vim.fn.serverstart(godot_project_path .. '/server.pipe')
    end

    if not is_godot_server_running then
      lsp.gdscript.setup{}
    end
    -- END GODOT

  end,
}
