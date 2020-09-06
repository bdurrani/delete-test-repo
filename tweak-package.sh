#!/usr/bin/env bash
set -euo pipefail

# printf '%s\n\n' "$current_time" >> README.md
npm version patch
npm i --package-lock-only
git push origin develop --tags 
