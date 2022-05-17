lua << END

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

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.75, -- Can be float or integer > 1
      },
      --{ id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      --{ id = "watches", size = 00.25 },
    },
    size = 60,
    position = "right", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
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


END


nnoremap <silent> <F4> :lua require'dap'.run({ type = 'java', request = 'attach', name = 'Debug (Attach) - Remote', hostName = '127.0.0.1', port = 5005 })<CR>
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>dso :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dsi :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>

nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>do :lua require'dapui'.toggle()<CR>
nnoremap <silent> <leader>dx :lua require'dap'.terminate()<CR>
