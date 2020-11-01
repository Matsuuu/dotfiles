#!/bin/bash

echo "===== Installing nvm ====="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash

echo "===== Verifying nvm installation ===="
bash
command -v nvm
