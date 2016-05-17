#!/usr/bin/env bash

#
# bashrc is loaded on all bash sessions (interactive and non-interactive)
#

# Load bashrc once
[ "$__DF_BASHRC" ] && return 0
export __DF_BASHRC=true

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

    # perl
    if [ -d /usr/local/lib/perl5 ]; then
      PERL5LIB="/usr/local/lib/perl5${PERL5LIB+:}${PERL5LIB}"
      export PERL5LIB
    fi
  fi
}
mac_setup

# Linux specific
linux_setup() {
  if [[ "$OSTYPE" == *'linux'* ]]; then
    [ -f /etc/bashrc ] && . /etc/bashrc
    ulimit -n 64000 >/dev/null 2>&1
    CNAME=$(hostname -d | cut -d. -f1)
    [ "$CNAME" ] && [ -d "/opt/${CNAME}-linux" ] && export PATH="/opt/${CNAME}-linux/bin:$PATH"
  fi
}
linux_setup

# Add "$HOME/bin" to path
[ "$HOME" ] && [ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Load .bash_common for interactive sessions
[ -t 0 ] && [ "$HOME" ] && [ ! "$__DF_BASH_COMMON" ] && [ -e "$HOME/.bash_common" ] && . "$HOME/.bash_common"
