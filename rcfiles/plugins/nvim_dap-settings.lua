local dap = require('dap')

dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "0.0.0.0";
    port = 5005;
  },
}

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='➡️', texthl='', linehl='DebugBreakpointLine', numhl=''})

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  --[[sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl", "console" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },--]]
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = { 
    max_type_length = nil, -- Can be integer or nil.
  }
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local dap = require('dap')
local api = vim.api
local keymap_restore = {}

vim.api.nvim_set_keymap("n", "<silent>F4", ":lua require'dap'.run({ type = 'java', request = 'attach', name = 'Debug (Attach) - Remote', hostName = '127.0.0.1', port = 5005 })<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>ds", ":lua require'dap'.run({ type = 'java', request = 'attach', name = 'Debug (Attach) - Remote', hostName = '127.0.0.1', port = 5005 })<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<silent>F5", ":lua require'dap'.continue()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>dc", ":lua require'dap'.continue()<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<silent>F10", ":lua require'dap'.step_over()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>dso", ":lua require'dap'.step_over()<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<silent>F11", ":lua require'dap'.step_into()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>dsi", ":lua require'dap'.step_into()<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<silent>F12", ":lua require'dap'.step_out()<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>do", ":lua require'dap'.toggle()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>dx", ":lua require'dap'.terminate()<CR>", { noremap = true })
