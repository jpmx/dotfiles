#!/usr/bin/env bash
#
# bashrc is loaded on all bash sessions (interactive and non-interactive)
#

# OS X Specific
mac_setup() {
  # Check if we have brew
  hash brew 2>&1 && export BREW_PREFIX="$(brew --prefix)" || return

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
}
[[ "$OSTYPE" == *'darwin'* ]] && mac_setup

# Linux specific
linux_setup() {
  [ -f /etc/bashrc ] && . /etc/bashrc
  ulimit -n 64000 >/dev/null 2>&1
  CNAME=$(hostname -d | cut -d. -f1)
  [ "$CNAME" ] && [ -d "/opt/${CNAME}-linux" ] && export PATH="/opt/${CNAME}-linux/bin:$PATH"
}
[[ "$OSTYPE" == *'linux'* ]] && linux_setup

# Aliases
setup_aliases() {
  export __CA="" && ls --color=auto >/dev/null 2>&1 && export __CA="--color=auto"
  alias rm="rm -i"
  alias cp="cp -i"
  alias mv="mv -i"
  alias ls="ls $__CA"
  alias ll="ls -l"
  alias lld="ls -lUd .*/ */"
  alias l="ls -CF"
  alias l.="ls -lA"
  alias la="ls -A"
  alias grep="grep $__CA"
  alias fgrep="fgrep $__CA"
  alias egrep="egrep $__CA"
  alias tree="tree -C"
}

# load aliases and add user's bin to path
if [ "$(echo ~)" != "/" ]; then
  [ -d ~/bin ] && export PATH=~/bin:$PATH
  # Setup aliases on interactive terminal
  [ -t 0 ] && [ ! "$(alias)" ] && setup_aliases
  # Load .bash_common for interactive sessions
  [ -t 0 ] && [ ! "$__DF_BASH_COMMON" ] && [ -e ~/.bash_common ] && . ~/.bash_common
fi
