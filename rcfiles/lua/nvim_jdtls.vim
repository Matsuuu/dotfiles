lua << END
-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/home/matsu/workspace/' .. project_name
--                                               ^^
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    'java', -- or '/path/to/java11_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    --'--add-modules', 'jdk.incubator.foreign',
    --'--add-modules', 'jdk.incubator.vector',

    -- 💀
    '-jar', vim.fn.glob('/home/matsu/Tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar'),
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', '/home/matsu/Tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  }
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

-- Custom picker for jdtls

local finders = require'telescope.finders'
local sorters = require'telescope.sorters'
local actions = require'telescope.actions'
local pickers = require'telescope.pickers'
local action_state = require'telescope.actions.state'
local cursor_theme = require'telescope.themes'.get_cursor

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
  local opts = cursor_theme{}
  local iterator = 0
  pickers.new(opts, {
    prompt_title = prompt,
    finder    = finders.new_table {
      results = items,
      entry_maker = function(entry)
        iterator = iterator + 1
        return {
          value = entry,
          display = tostring(iterator) .. ": " .. label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry(prompt_bufnr)

        actions.close(prompt_bufnr)

        cb(selection.value)
      end)

      return true
    end,
  }):find()
end
END

command! -buffer JdtCompile lua require('jdtls').compile()
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()

"" Remaps for jdtls

noremap <Leader><CR> <Cmd>lua require('jdtls').code_action()<CR>
nnoremap <Leader>oi  <Cmd>lua require'jdtls'.organize_imports()<CR>
vnoremap <Leader>em  <Esc><Cmd>lua require('jdtls').extract_method(true)<CR> 
