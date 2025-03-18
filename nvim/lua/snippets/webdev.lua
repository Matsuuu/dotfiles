local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

local function to_pascal_case(_, snip)
  local filename = vim.fn.expand("%:t:r")
  -- Convert kebab-case to PascalCase
  local pascal = filename:gsub("(%-%a)", function(match)
    return match:sub(2, 2):upper()
  end)
  -- Ensure first letter is uppercase
  pascal = pascal:gsub("^%a", string.upper)
  return pascal
end

local function to_custom_element(_, snip)
  local filename = vim.fn.expand("%:t:r")
  return filename
end


ls.add_snippets("javascript", {
    s("LitElemTW", {
          t('import { html, LitElement } from "lit";'), t({"", ""}),
          t('import { customElement, property } from "lit/decorators.js";'), t({"", ""}),
          t('import { withTailwind } from "@shared/css/tailwind";'), t({"", "", ""}),
          t('@customElement("'), f(to_custom_element), t('")'), t({"", ""}),
          t('@withTailwind'), t({"", ""}),
          t('export class '), f(to_pascal_case), t(' extends LitElement {'), t({"", "    "}),
          t('@property({ type: String })'), t({"", "    "}),
          t('name = "'), t("World"), t('";'), t({"", "", "    "}),
          t('render() {'), t({"", "        "}),
          t('return html`<p>Hello ${this.name}</p>`;'), t({"", "    "}),
          t('}'), t({"", "}"}),
    })
})

ls.add_snippets("typescript", ls.get_snippets("javascript"))
ls.add_snippets("typescriptreact", ls.get_snippets("javascript"))
ls.add_snippets("javascriptreact", ls.get_snippets("javascript"))
