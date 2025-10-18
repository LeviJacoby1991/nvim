return {
  'neovim/nvim-lspconfig',
  config = function()
    local servers = { 'gopls', 'clangd', 'rust_analyzer', 'lua_ls', 'graphql', 'ts_ls', 'buf_ls', 'pyright'}

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

    mason.setup()
    mason_lsp_config.setup({
      automatic_installation = true,
      ensure_installed = servers,
      automatic_enable = {exclude = 'gopls'},
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/formatting') then
          vim.keymap.set('n', ',F', vim.lsp.buf.format, { desc = 'Format Buffer' })
        end

        if client:supports_method('textDocument/definition') then
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
        end

        if client:supports_method('textDocument/declaration') then
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
        end
      end
    })

    vim.lsp.config('ruby-lsp', {
      cmd = { 'ruby-lsp' },
      default_config = {
        cmd = {'ruby-lsp'},
        filetypes = {'ruby'},
        root_markers = { {'Gemfile'}, '.git'},
        init_options = {
          formatter = 'standard',
          linters = { 'standard' }
        }
      },
      filetypes = { 'ruby' },
    })
    vim.lsp.enable('ruby-lsp')

    -- GODOT
    -- paths to check for project.godot file
    local paths_to_check = {'/', '/../'}
    local is_godot_project = false
    local godot_project_path = ''
    local cwd = vim.fn.getcwd()

    -- iterate over paths and check
    for _, value in pairs(paths_to_check) do
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
      vim.lsp.config('gdscript', {})
    end
    -- END GODOT

  end,
}
