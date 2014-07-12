#!/usr/bin/env bash

#
# bashrc is loaded on all bash sessions (interactive and non-interactive)
#

# Load bashrc once
[ "$__DF_BASHRC_LOADED" ] && return 0
__DF_BASHRC_LOADED=true

# OS X Specific
mac_setup() {
  # HomeBrew setup
  if [[ "$OSTYPE" == *'darwin'* ]]; then
    # Check if we have brew
    which brew >/dev/null 2>&1 && export BREW_PREFIX="$(brew --prefix)" || return

    # Add brew's path
    export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

    # Add GNU coreutils to path
    [ -d /usr/local/opt/coreutils/libexec/gnubin ] && \
      export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

    # Add GNU's tar to path
    [ -x /usr/local/opt/gnu-tar/libexec/gnubin/tar ] && \
      export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

    # Setup and load nvm
    [ -d ~/.nvm ] && export NVM_DIR=~/.nvm
    [ -f "$BREW_PREFIX/opt/nvm/nvm.sh" ] &&. "$BREW_PREFIX/opt/nvm/nvm.sh"

  fi
}
mac_setup

# Linux specific
linux_setup() {
  if [[ "$OSTYPE" == *'linux'* ]]; then
    [ -f /etc/bashrc ] && . /etc/bashrc
    ulimit -n 64000 >/dev/null 2>&1
  fi
}
linux_setup

# Add "$HOME/bin" to path
[ "$HOME" ] && [ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Load bash_profile for interactive sessions
[ -t 0 ] && [ ! "$__DF_BASH_PROFILE_LOADED" ] && [ -e "$HOME/.bash_profile" ] && . "$HOME/.bash_profile"
