# Release branch detection action
[![Linting](https://github.com/Edgaraszs/release-branch-detection/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/Edgaraszs/release-branch-detection/actions/workflows/shellcheck.yml)

This GitHub action detects new release branch and archives old release branches.

## Introduction

## Example usage

```yaml
name: Release branch detection
on:
  push:
    branches:
      - 'release/**'
jobs:
  release-branch-detection:
    if: github.event.created
    name: Release branch detection
    runs-on: ubuntu-latest
    steps:
      - name: Run release-branch-detection
        uses: Edgaraszs/release-branch-detection@v1
        with:
          github_token: ${{ github.token }}
```
