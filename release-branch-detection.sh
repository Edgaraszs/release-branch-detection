#!/bin/bash
set -eo pipefail

[[ -n ${INPUT_GITHUB_TOKEN} ]] || { echo "Please set the GITHUB_TOKEN input"; exit 1; }

get_release_branches() {
    local branches
    branches=$(curl -s -H "Authorization: Bearer ${INPUT_GITHUB_TOKEN}" \
        -H "Accept: application/vnd.github+json" \
        "https://api.github.com/repos/${GITHUB_REPOSITORY}/branches" | jq -r '.[] | select(.name | startswith("release")) | .name')
}

main() {
    local release_branches
    release_branches=$(get_release_branches)
    echo "Release branches: ${release_branches}"
}

main '$@'