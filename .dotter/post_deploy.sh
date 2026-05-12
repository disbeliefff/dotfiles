#!/bin/bash
set -euo pipefail
cd ~/dotfiles

TOKEN=$(sops --decrypt --extract '["youtrack_token"]' secrets/secrets.enc.yaml)
python3 -c "
import json, sys
token = sys.argv[1]
path = sys.argv[2].strip()
with open(path) as f:
    cfg = json.load(f)
cmd = cfg['mcp']['youtrack']['command']
for i, part in enumerate(cmd):
    if part.startswith('Authorization: Bearer'):
        cmd[i] = f'Authorization: Bearer {token}'
        break
with open(path, 'w') as f:
    json.dump(cfg, f, indent=2)
    f.write('\n')
" "$TOKEN" ~/.config/opencode/config.json

git commit -am "auto: sync dotfiles $(date '+%Y-%m-%d %H:%M')" && git push
git push --set-upstream origin main
