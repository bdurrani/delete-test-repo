#!/usr/bin/env bash

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
echo "$current_time" >> README.md

git add .
git commit -m "change: ${current_time}"

echo "Local change made. Wait for remote change"
read -t 3 -n 1

echo "Pulling"
git pull origin