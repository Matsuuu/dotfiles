local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local function current_file()
    return vim.api.nvim_buf_get_name(0)
end

local function get_package_name()
    return f(function(args, snip)
       local curr = current_file()
       local start = string.find(curr, "java")
       local package_path = string.sub(curr, start + string.len("java"))

       local package_name = ""

       for package_layer in string.gmatch(package_path, "%/%w+") do
            package_name = package_name .. string.gsub(package_layer, "/", ".")
       end

       -- Remove the class name and the starting period
       return string.sub(string.gsub(package_name, "%.%w+$", ";"), 2);
   end)
end

local function filename()
    return f(function (args, snip)
        local _, __, name = string.find(current_file(), "(%w+)(%." .. vim.bo.filetype .. ")")
        return name or ""
    end)
end

local newfile = s("newfile", {
    fmt("package {};", {
        get_package_name()
    }),
    fmt("\npublic class {} ", {
        filename()
    })

})

return {
    newfile
}
