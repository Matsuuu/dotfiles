#!/bin/bash

echo "===== Installing nvm ====="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

echo "===== Verifying nvm installation ===="
exec bash
command -v nvm
nvm install node
