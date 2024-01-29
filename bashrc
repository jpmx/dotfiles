#!/usr/bin/env bash
#
# bashrc is loaded on all bash sessions (interactive and non-interactive)
#
export __DF_BASHRC=true

# Try fix missing HOME
[ ! "$HOME" ] && export HOME="$(printf ~ 2>/dev/null)"

# OS X Specific
mac_setup() {
  # Check if we have brew
  hash brew 2>&1 && export BREW_PREFIX="$(brew --prefix)" || return

  # Add GNU coreutils to path
  [ -d /usr/local/opt/coreutils/libexec/gnubin ] && \
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

  # Add GNU's tar to path
  [ -x /usr/local/opt/gnu-tar/libexec/gnubin/tar ] && \
    PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

  # add vscode to gitconfig
  ! grep -q 'code --wait --new-window' ~/.gitconfig && git config --global core.editor 'code --wait --new-window'
  if ! grep -q 'tool = vscode' ~/.gitconfig; then
      git config --global diff.tool vscode
      git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
      git config --global merge.tool vscode
      git config --global mergetool.vscode.cmd 'code --wait $MERGED'
  fi

  # Cargo
  [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
  
  # FNM
  [ ! "$FNM_MULTISHELL_PATH" ] && [ -f /opt/homebrew/bin/fnm ] && eval "$(/opt/homebrew/bin/fnm env --use-on-cd)"
}
[[ "$OSTYPE" == *'darwin'* ]] && mac_setup

# Linux specific
linux_setup() {
  # Default PATH for *NIX
  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  [ -f /etc/bashrc ] && . /etc/bashrc
  ulimit -n 64000 >/dev/null 2>&1
  for DPATH in /opt/*-linux/bin; do
    [ -d "$DPATH" ] && PATH="$DPATH:$PATH"
  done
}
[[ "$OSTYPE" == *'linux'* ]] && linux_setup

# Aliases
setup_aliases() {
  __CA="" && ls --color=auto >/dev/null 2>&1 && __CA="--color=auto"
  alias ls="ls $__CA"
  alias ll="ls -ltr"
  alias lld="ls -lUd .*/ */"
  alias l="ls -CF"
  alias l.="ls -lA"
  alias la="ls -A"
  alias grep="grep $__CA"
  alias fgrep="fgrep $__CA"
  alias egrep="egrep $__CA"
  alias tree="tree -C"
  alias hist="history"
}

# load aliases and add user's bin to path
if [ "$(echo ~)" != "/" ]; then
  [ -d ~/bin ] && PATH=~/bin:$PATH
  # Setup aliases on interactive terminal
  [ -t 0 ] && setup_aliases
  # Load .bash_common for interactive sessions
  [ -t 0 ] && [ ! "$__DF_BASH_COMMON" ] && [ -e ~/.bash_common ] && . ~/.bash_common
fi
