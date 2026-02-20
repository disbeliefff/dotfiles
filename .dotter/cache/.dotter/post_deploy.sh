#!/bin/bash
cd ~/dotfiles
git commit -am "auto: sync dotfiles $(date '+%Y-%m-%d %H:%M')" && git push
git push --set-upstream origin main
