#!/usr/bin/env bash

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
# printf '%s\n\n' "$current_time" >> README.md
npm version minor
npm ci

git add .
git commit -m "change: ${current_time}"

echo "Local change made. Wait for remote change"
read year
# read -t 3 -n 1

echo "Pulling"
git pull origin
git push origin