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

vim.api.nvim_set_hl(0, "ClearColor", { fg = "", bg = "" })
vim.api.nvim_set_hl(0, "NormalColor", { fg = "#fff0f5", bg = "#2d2f42" })
vim.api.nvim_set_hl(0, "VisualColor", { fg = "#202330", bg = "#fff0f5" })
vim.api.nvim_set_hl(0, "InsertColor", { fg = "#fff0f5", bg = "#472541" })
vim.api.nvim_set_hl(0, "CommandColor", { fg = "#fff0f5", bg = "#6d7a72" })



local function get_mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function get_mode_color()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "n" or mode == "no" then
        return "%#NormalColor#"
    end
    if mode == "v" or mode == "V" then
        return "%#VisualColor#"
    end
    if mode == "i" or mode == "ic" then
        return "%#InsertColor#"
    end
    if mode == "c"  then
        return "%#CommandColor#"
    end

    return "%#NormalColor#"
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
        get_mode_color(),
        get_mode(),
        "%#ClearColor#",
        "%="; -- Above, left side, below center
        "",
        get_filepath(),
        get_filename(),
        "%=", -- Above, center, below, right
        "Foo"
    })
end

StatusLine.inactive = function()
    return ""
end

StatusLine.short = function()
    return ""
end

StatusLine.init = function()
    vim.opt.showmode = false

    local StatusLineGroup = vim.api.nvim_create_augroup("StatusLine", {})

    vim.api.nvim_create_autocmd(
        { "ModeChanged", "WinEnter", "BufEnter", "FocusGained", "InsertLeave", "InsertEnter" },
        {
            pattern = "*",
            callback = function(ev)
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
