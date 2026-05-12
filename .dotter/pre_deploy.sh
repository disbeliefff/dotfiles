#!/bin/bash
set -e
cd ~/dotfiles

sops --decrypt secrets/secrets.enc.yaml | python3 -c "
import sys, yaml
data = yaml.safe_load(sys.stdin)
print('[default.variables]')
for k, v in data.items():
    print(f'{k} = \"{v}\"')
" > local.toml
