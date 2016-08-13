#!/usr/bin/env bash
export __DF_PROFILE=true && [ ! "$__DF_BASHRC" ] && [ -f ~/.bashrc ] && . ~/.bashrc
###################################################################################
#
# Use this file for custom settings, this file is never replaced
#
###################################################################################

# Export custom PATH
# export PATH="/my/custom/path:$PATH"

# Create your API token on https://github.com/settings/tokens
export HOMEBREW_GITHUB_API_TOKEN=""

# Git uses these environment variables as its primary source of information
export GIT_AUTHOR_NAME=""
export GIT_AUTHOR_EMAIL=""
export GIT_COMMITTER_NAME=""
export GIT_COMMITTER_EMAIL=""
