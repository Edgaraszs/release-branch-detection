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

rename_to_archive() {
    local branch="$1"

    echo "Renaming branch: ${branch} to archive/${branch}"
        curl -s \
            -X POST \
            -H "Accept: application/vnd.github+json" \
            -H "Authorization: Bearer ${REPO_TOKEN}" \
            "https://api.github.com/repos/${REPO}/branches/${branch}/rename" \
            -d '{"new_name":"archive/'"${branch}"'"}'
}

main() {
    local release_branches
    release_branches=$(get_release_branches)
    echo "Release branches: ${release_branches}"

    local -A release_versions=()

    while IFS= read -r branch; do
        version=$(echo "$branch" | sed 's/release\/v//; s/[^0-9]//g')

        release_versions["$branch"]="$version"
    done <<< "$release_branches"

    highest_version=0

    for branch in "${!release_versions[@]}"; do
        version="${release_versions[$branch]}"
        if (( version > highest_version )); then
            highest_version="$version"
        fi
    done

    for branch in "${!release_versions[@]}"; do
        version="${release_versions[$branch]}"
        if (( version != highest_version )); then
            rename_to_archive "$branch"
        fi
    done

    echo "Highest release version: $highest_version"
}

main '$@'