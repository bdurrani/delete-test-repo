#!/usr/bin/env bash
set -euo pipefail

git pull origin 

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
printf 'tweak %s\n\n' "$current_time" >> README.md
git add .
git commit -m "change: ${current_time}" || true


git pull origin
git push origin