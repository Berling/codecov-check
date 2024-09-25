#!/bin/bash

set -ex
export REPO_NAME=$(echo "$GITHUB_REPOSITORY" | sed -e "s/^$GITHUB_REPOSITORY_OWNER\///")
export TOTAL_COVERAGE=$(curl --location --request GET "https://codecov.io/api/v2/github/$GITHUB_REPOSITORY_OWNER/repos/$REPO_NAME/totals?branch=$GITHUB_REF_NAME" --header "Authorization: bearer $INPUT_TOKEN" | jq .totals.coverage)
if [ "$(echo "$TOTAL_COVERAGE < $INPUT_THRESHOLD" | bc)" -eq 1  ]; then
  echo "::error title=Code Coverage Target Missed::Total code coverage is below threshold of $INPUT_THRESHOLD%"
  exit 1
fi
