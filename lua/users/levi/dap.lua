local dap_ok, dap  = pcall(require, 'dap')
if not dap_ok then
  return
end

local dapui_ok, dapui  = pcall(require, 'dapui')
if not dapui_ok then
  return
end

local dap_vt_ok, dap_vt = pcall(require, 'nvim-dap-virtual-text')
if not dap_vt_ok then
  return
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

dapui.setup({
  controls = {
    element = "repl",
    enabled = true,
    icons = {
      disconnect = "",
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = ""
    }
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = "single",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
  force_buffers = true,
  icons = {
    collapsed = "",
    current_frame = "",
    expanded = ""
  },
  layouts = { {
      elements = { {
          id = "scopes",
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.25
        } },
      position = "left",
      size = 40
    }, {
      elements = { {
          id = "repl",
          size = 0.5
        }, {
          id = "console",
          size = 0.5
        } },
      position = "bottom",
      size = 10
    } },
  mappings = {
    edit = "e",
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    repl = "r",
    toggle = "t"
  },
  render = {
    indent = 1,
    max_value_lines = 100
  }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  require("dapui").open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  require("dapui").close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  require("dapui").close()
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
