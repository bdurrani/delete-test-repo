#!/usr/bin/env bash
set -euo pipefail

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
# printf '%s\n\n' "$current_time" >> README.md
npm version minor
npm ci

git add .
git commit -m "change: ${current_time}" || true

readonly HEAD_SHA=$(git rev-parse --short HEAD)
git tag "tag-${HEAD_SHA}"

echo "Local change made. Wait for remote change"
read year
# read -t 3 -n 1

echo "Pulling"
git pull origin --no-edit 
# git fetch origin
# git merge origin -m "Merging changes"
git push origin