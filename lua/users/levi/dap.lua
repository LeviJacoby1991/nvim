local dapui = require'dapui'
local dap = require'dap' 
local dap_vt = require'nvim-dap-virtual-text'

function map(mode, lhs, rhs, opts)
  vim.keymap.set()
end

dap_vt.setup {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = true,
}

dapui.setup()--{
  --mappings = {
  --  icons = { expanded = "▾", collapsed = "▸" },
  --  expand = { "<CR>" },
  --  open = "o",
  --  remove = "d",
  --  edit = "e",
  --  repl = "r",
  --  toggle = "t"
  --},
  --expand_lines = true,
  --layouts = {
  --  elements = {
  --    { id = scopes, size = 0.25 },
  --    "breakpoints",
  --    "stacks",
  --    "watches",
  --  },
  --  size = 40,
  --  position = "left",
  --}, 
  --{
  --  elements = {
  --    "repl",
  --    "console",
  --  },
  --  size = 0.25,
  --  position = "bottom",
  --},
  --floating = {
  --  max_height = nil,
  --  max_width = nil,
  --  border = "rounded",
  --  mappings = {
  --    close = { "q", "<Esc>" },
  --  },
  --},
  --windows = { indent = 1 },
  --render = { max_type_length = nil },
--}

--dap.set_log_level('TRACE')

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.ccpdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.stdpath "data" .. '/mason/bin/OpenDebugAD7',
}

dap.configurations.c = {
  {
    type = 'ccpdbg',
    request = 'launch',
    program = '$(file)',
    cwd = vim.fn.getcwd(),
    program = function()
      return vim.fn.input('executable:', vim.fn.getcwd() .. '/', 'file')
    end
  }
}
