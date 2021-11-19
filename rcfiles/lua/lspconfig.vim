lua << END
local on_attach_vim = function(client)
    --require'completion'.on_attach(client)
    lsp_status.on_attach(client)
    capabilities = lsp_status.capabilities
end

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup{ on_attach=on_attach_vim }
lspconfig.jsonls.setup{ on_attach=on_attach_vim }
lspconfig.html.setup{ on_attach=on_attach_vim }
--lspconfig.jdtls.setup{ on_attach=on_attach_vim }
lspconfig.cssls.setup{ on_attach=on_attach_vim }
lspconfig.clojure_lsp.setup{ on_attach=on_attach_vim }
lspconfig.gopls.setup { on_attach=on_attach_vim }
END
