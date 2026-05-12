#!/bin/bash
set -euo pipefail
cd ~/dotfiles

sops --decrypt secrets/secrets.enc.yaml | python3 -c "
import yaml, sys

secrets = yaml.safe_load(sys.stdin)
path = '.dotter/local.toml'

with open(path) as f:
    lines = f.readlines()

in_vars = False
written_keys = set()
new_lines = []

for line in lines:
    stripped = line.strip()
    if stripped == '[variables]':
        in_vars = True
    elif stripped.startswith('[') and in_vars:
        for k in secrets:
            if k not in written_keys:
                v = str(secrets[k]).replace('\\\\', '\\\\\\\\').replace('\"', '\\\\\"')
                new_lines.append(f'{k} = \"{v}\"\\n')
                written_keys.add(k)
        in_vars = False

    if in_vars and '=' in stripped:
        key = stripped.split('=', 1)[0].strip()
        if key in secrets:
            v = str(secrets[key]).replace('\\\\', '\\\\\\\\').replace('\"', '\\\\\"')
            new_lines.append(f'{key} = \"{v}\"\\n')
            written_keys.add(key)
            continue

    new_lines.append(line)

if in_vars:
    for k in secrets:
        if k not in written_keys:
            v = str(secrets[k]).replace('\\\\', '\\\\\\\\').replace('\"', '\\\\\"')
            new_lines.append(f'{k} = \"{v}\"\\n')

with open(path, 'w') as f:
    f.writelines(new_lines)
"
