#!/usr/bin/env bash
set -euo pipefail

# printf '%s\n\n' "$current_time" >> README.md
npm version prerelease --preid=alpha
npm i --package-lock-only
git pull origin 
git push origin develop --tags 
