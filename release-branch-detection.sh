#!/bin/bash
set -eo pipefail

[[ -n ${INPUT_GITHUB_TOKEN} ]] || { echo "Please set the GITHUB_TOKEN input"; exit 1; }

REPO=${GITHUB_REPOSITORY}
REPO_TOKEN=${INPUT_GITHUB_TOKEN}

get_release_branches() {
    local branches
    branches=$(curl -s -H "Authorization: Bearer ${REPO_TOKEN}" \
        -H "Accept: application/vnd.github+json" \
        "https://api.github.com/repos/{$REPO}/branches")
    echo "${branches}" | jq -r '.[] | select(.name | startswith("release")) | .name'
}

main() {
    local release_branches
    release_branches=$(get_release_branches)
    echo "Release branches: ${release_branches}"

    while IFS= read -r branch; do
        version=$(echo "$branch" | sed 's/release\/v//')
        echo "Version number for branch $branch: $version"
    done <<< "$release_branches"
}

main '$@'