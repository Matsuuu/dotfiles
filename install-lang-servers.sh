#!/bin/bash
nvim \
    -c "LspInstall tsserver" \
    -c "LspInstall html" \
    -c "LspInstall cssls" \
    -c "LspInstall jdtls" \
    -c "LspInstall jsonls"
