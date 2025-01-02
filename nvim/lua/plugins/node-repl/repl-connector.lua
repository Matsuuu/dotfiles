local uv = vim.loop

local buf, win
local handle, pid
local stdin_pipe = uv.new_pipe(false)
local stdout_pipe = uv.new_pipe(false)

local function on_stdout(err, data)
    assert(not err, err)

    vim.schedule(function()
        if data then
            vim.api.nvim_buf_call(buf, function()
                data = string.gsub(data, "\0", "")
                data = string.gsub(data, "\n", "")

                vim.api.nvim_put({data}, "l", true, true)
                vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
            end)
        end
    end)
end

local function create_window()
    local width = 50
    local height = 10

    buf = vim.api.nvim_create_buf(false, true)
    local ui = vim.api.nvim_list_uis()[1]

    local opts = {
        ["relative"] = "win",
        ["width"] = width,
        ["height"] = height,
        ["col"] = ui.width - 0,
        ["row"] = ui.height - 15,
        ["anchor"] = "NE",
        ["style"] = "minimal",
    }

    win = vim.api.nvim_open_win(buf, 1, opts)
end

local function create_handle()
    handle, pid = uv.spawn("virta", {
            args = { "" },
            stdio = { stdin_pipe, stdout_pipe, nil }
        }, function (code, signal)
            print("Nodejs process exited. Code: ", code, ", Signal:", signal)
            stdin_pipe:close()
            stdout_pipe:close()
            handle:close()
        end)


    if not handle then
      error("Failed to start Node.js process")
    end

    uv.read_start(stdout_pipe, on_stdout)
end


local function send_input(input)
    stdin_pipe:write(input .. "\n")
end

local function get_visual_selection()
    -- Get the start and end positions of the visual selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    -- print(vim.inspect({ start_pos, end_pos }))

    local start_line, start_col = start_pos[2], start_pos[3]
    local end_line, end_col = end_pos[2], end_pos[3]

    -- If the selection is invalid, return early
    if start_line == 0 or end_line == 0 then
        return
    end

    local lines = vim.fn.getline(start_line, end_line);
    if #lines == 0 then return end

    -- Adjust selection for first and last line
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)

    return lines
end


local function virta_visual_eval()
    local mode = vim.fn.mode()
    local input

    -- Let's just use this until we find a better one.
    vim.cmd("normal! :<C-c>")

    if mode =="v" or mode == "V" then
        input = get_visual_selection()
    else
        input = { vim.api.nvim_get_current_line() }
    end

    if input == nil then
        print("Could not find selection")
        return
    end
    -- print(vim.inspect(input))

    local input_string = table.concat(input, "\n")

  if input == "__node_repl_exit" then
    stdin_pipe:close()
    handle:close()
    print("Exiting Node.js program.")
  else
    send_input(input_string)
  end
end

local function virta_normal_eval()
    virta_visual_eval()
end

local function virta_buffer_eval()
    print("Not implemented")
end

create_handle()
create_window()

vim.keymap.set("v", "<leader>ev", virta_visual_eval)
vim.keymap.set("n", "<leader>ev", virta_normal_eval)
vim.keymap.set("n", "<leader>eb", virta_buffer_eval)
