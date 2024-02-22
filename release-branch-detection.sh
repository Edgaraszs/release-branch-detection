#!/bin/bash
set -eo pipefail

[[ -n ${INPUT_GITHUB_TOKEN} ]] || { echo "Please set the GITHUB_TOKEN input"; exit 1; }

main() {
  echo "Hello world"
  time=$(date)
  echo "time=$time" >> $GITHUB_OUTPUT
}

main '$@'