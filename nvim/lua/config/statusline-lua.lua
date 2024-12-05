local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function get_mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function get_filepath()
    local filepath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
    if filepath == "" or filepath == "." then
        return " "
    end

    return string.format(" %%<%s/", filepath);
end

local function get_filename()
    local filename = vim.fn.expand("%:t")
    if filename == "" then
        return ""
    end

    return filename .. " "
end

StatusLine = {}

StatusLine.active = function()
    return table.concat({
        get_mode(),
        "",
        get_filepath(),
        get_filename(),
        ""
    })
end

StatusLine.inactive = function()
    return ""
end

StatusLine.short = function()
    return ""
end

StatusLine.init = function()
    -- vim.api.nvim_exec([[
    --   augroup Statusline
    --   au!
    --   au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
    --   au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
    --   au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
    --   augroup END
    -- ]], false)
    vim.opt.showmode = false

    local StatusLineGroup = vim.api.nvim_create_augroup("StatusLine", {})
    vim.api.nvim_create_autocmd(
        { "WinEnter", "BufEnter", "FocusGained", "InsertLeave", "InsertEnter" },
        {
            pattern = "*",
            callback = function(ev)
                print(string.format('event fired: %s', vim.inspect(ev)))
                local current_mode = vim.api.nvim_get_mode().mode
                print("Current mode: ", current_mode)
                vim.wo.statusline = StatusLine.active()
            end,
            group = StatusLineGroup
        }
    )

    vim.api.nvim_create_autocmd(
        { "BufLeave", "WinLeave",  },
        {
            pattern = "*",
            callback = function()
                vim.wo.statusline = StatusLine.inactive()
            end,
            group = StatusLineGroup
        }
    )
end

StatusLine.init()

return StatusLine
