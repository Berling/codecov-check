#!/bin/bash

set -ex
export REPO_NAME=$(echo "${{ github.repository }}" | sed -e "s/^${{ github.repository_owner }}\///")
export TOTAL_COVERAGE=$(curl --location --request GET "https://codecov.io/api/v2/github/${{ github.repository_owner }}/repos/$REPO_NAME/totals?branch=${{ github.ref_name }}" --header "Authorization: bearer ${{ input.token }}" | jq .totals.coverage)
if [ "$(echo "$TOTAL_COVERAGE < ${{ input.threshold }}" | bc)" -eq 1  ]; then
  echo "::error title=Code Coverage Target Missed::Total code coverage is below threshold of ${{ input.threshold }}%"
  exit 1
fi
