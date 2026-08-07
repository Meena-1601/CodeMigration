#!/bin/bash
set -euo pipefail

SOURCE_BASE="https://github.com/Meena-1601"
TARGET_BASE="https://${DEST_PAT_USER}:${DEST_PAT_TOKEN}@github.com/meenasubashri1998-code"

echo "DEBUG: SOURCE_PAT_USER length: ${#SOURCE_PAT_USER}"

repos=(
  python-app-deploy
  aws_resource_list.sh
  Jenkins-pipeline
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
