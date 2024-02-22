# Release branch detection docker action

This GitHub action detects new release branch and archives old release branches.

## Inputs

## `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

## `time`

The time we greeted you.

## Example usage

uses: actions/release-branch-detection@v1
with:
who-to-greet: 'Mona the Octocat'