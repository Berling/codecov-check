#!/bin/bash

set -ex
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | sed -e "s/^$GITHUB_REPOSITORY_OWNER\///")
[ -n "$REPO_NAME" ] || exit 1
TOTAL_COVERAGE=$(curl --location --request GET "https://codecov.io/api/v2/github/$GITHUB_REPOSITORY_OWNER/repos/$REPO_NAME/totals?branch=$GITHUB_REF_NAME" --header "Authorization: bearer $INPUT_TOKEN" | jq .totals.coverage)
[ -n "$TOTAL_COVERAGE" ] || exit 1
RESULT=$(echo "$TOTAL_COVERAGE < $INPUT_THRESHOLD" | bc)
[ -n "$RESULT" ] || exit 1
if [ "$RESULT" -eq 1  ]; then
  echo "::error title=Code Coverage Target Missed::Total code coverage is below threshold of $INPUT_THRESHOLD%"
  exit 1
fi
