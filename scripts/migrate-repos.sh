#!/bin/bash
set -euo pipefail

SOURCE_OWNER="Meena-1601"
DEST_OWNER="meenasubashri1998-code"

repos=(
  python-app-deploy
  aws_resource_list.sh
  Jenkins-pipeline
  git-pjt
)

for repo in "${repos[@]}"
do
  echo "Migrating ${repo} ..."

  # Clone from source using extraheader auth (avoids URL-embedded token issues)
  git clone --mirror "https://github.com/${SOURCE_OWNER}/${repo}.git" "${repo}.git"

  cd "${repo}.git"

  # Push to destination using extraheader auth
  git -c http.extraheader="Authorization: token ${DEST_PAT_TOKEN}" \
    push --mirror "https://github.com/${DEST_OWNER}/${repo}.git"

  cd ..
  rm -rf "${repo}.git"

  echo "$repo migrated successfully"
done
