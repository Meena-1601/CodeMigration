#!/bin/bash
set -euo pipefail

SOURCE_BASE="https://${SOURCE_GITHUB_USERNAME}:${SOURCE_GITHUB_PAT}@github.com/Meena-1601"
TARGET_BASE="https://${DEST_GITHUB_USERNAME}:${DEST_GITHUB_PAT}@github.com/meenasubashri1998-code"

repos=(
  git-pjt
)

for repo in "${repos[@]}"
do
  echo "Migrating ${repo} ..."

  git clone --mirror "$SOURCE_BASE/${repo}.git"

  cd "${repo}.git"

  git remote set-url origin "$TARGET_BASE/${repo}.git"

  git push --mirror

  cd ..
  rm -rf "${repo}.git"

  echo "$repo migrated successfully"
done
