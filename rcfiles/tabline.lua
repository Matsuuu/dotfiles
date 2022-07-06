function TabLine()
    local tabLine = ""
    for i = 1, vim.fn.tabpagenr("$"), 1 do
        local windowNumber = vim.fn.tabpagewinnr(i)
        local bufferList = vim.fn.tabpagebuflist(i)

        local bufferNumber = bufferList[windowNumber]
        local bufferName = vim.fn.fnamemodify(vim.fn.bufname(bufferNumber), ":t")
        local filetype = vim.fn.getbufvar(bufferNumber, '&filetype')

        tabLine = tabLine .. "%#TabLineFill# | "
        tabLine = tabLine .. (i == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#")

        if string.len(bufferName) <= 0 then
            tabLine = tabLine .. "[No Name]"
        else
            local icon = require'nvim-web-devicons'.get_icon(bufferName, filetype, { default = true })
            if icon then
                tabLine = tabLine ..  icon .. " "
            end
            tabLine = tabLine .. bufferName
        end

        local modified = vim.fn.getbufvar(bufferNumber, "&mod")
        if modified == 1 then
            tabLine = tabLine .. " + "
        end
    end
    tabLine = tabLine .. "%#TabLineFill#"

    return tabLine
end


function Setup()
    vim.opt.tabline = "%!v:lua.require'rcfiles.tabline'.TabLine()"
end

return {
    Setup = Setup,
    TabLine = TabLine
}
