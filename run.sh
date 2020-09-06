#!/usr/bin/env bash
set -euo pipefail


function detect_merge_conflict(){
    git merge --ff-only
}

function is_pull_needed(){

    git remote update

    local UPSTREAM=${1:-'@{u}'}
    local LOCAL=$(git rev-parse @)
    local REMOTE=$(git rev-parse "$UPSTREAM")
    local BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
        echo "Up-to-date"
    elif [ $LOCAL = $BASE ]; then
        echo "Need to pull"
    elif [ $REMOTE = $BASE ]; then
        echo "Need to push"
    else
        echo "Diverged, Need to pull"
    fi
}

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
# printf '%s\n\n' "$current_time" >> README.md
npm version minor
npm i --package-lock-only

git add .
git commit -m "change: ${current_time}" || true

readonly HEAD_SHA=$(git rev-parse --short HEAD)
git tag "tag-${HEAD_SHA}"

echo "Local change made. Wait for remote change"
read year
# read -t 3 -n 1

echo "Pulling"

is_pull_needed 

# git pull origin --no-edit 
git fetch origin
git merge develop -m "Merging changes" --ff-only
git push origin develop --tags 

# merge to master
echo "Merging develop to master"
git checkout master
git pull origin master
git merge develop

# push to master
echo "Pushing master"
git push origin master --tags

# switch back to develop
git checkout develop