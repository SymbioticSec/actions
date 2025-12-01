#!/bin/bash

# Collect Git repository information
# This script collects git info and sets output variables
# Usage: source this script and call collect_git_info <output_prefix>

collect_git_info() {
    local output_prefix="${1:-git_info}"
    
    echo -e "\033[1;34m⭐ Collecting git information...\033[0m"

    local remote_url
    local first_commit_sha
    local latest_commit_sha
    local current_branch

    remote_url="$(git config --get remote.origin.url)"
    first_commit_sha="$(git rev-list --max-parents=0 HEAD | head -n 1)"
    latest_commit_sha="$(git rev-parse HEAD)"
    current_branch="$(git branch --show-current)"

    # Export as environment variables with prefix
    export "${output_prefix}_remote_url=$remote_url"
    export "${output_prefix}_first_commit_sha=$first_commit_sha"
    export "${output_prefix}_latest_commit_sha=$latest_commit_sha"
    export "${output_prefix}_current_branch=$current_branch"
    
    # Make them available to subsequent steps in GitHub Actions
    if [[ -n "$GITHUB_ENV" ]]; then
        echo "${output_prefix}_remote_url=$remote_url" >> "$GITHUB_ENV"
        echo "${output_prefix}_first_commit_sha=$first_commit_sha" >> "$GITHUB_ENV"
        echo "${output_prefix}_latest_commit_sha=$latest_commit_sha" >> "$GITHUB_ENV"
        echo "${output_prefix}_current_branch=$current_branch" >> "$GITHUB_ENV"
    fi

    echo -e "\033[1;32m✓ Git info collected\033[0m"
}
