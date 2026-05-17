#!/usr/bin/env bash
#
# bashrc is loaded on all bash sessions (interactive and non-interactive)
#
__DF_BASHRC=true

# Try fix missing HOME
[ ! "$HOME" ] && export HOME="$(printf ~ 2>/dev/null)"

# OS X Specific
mac_setup() {
  # Check if we have brew
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    return
  fi

  # Add GNU coreutils to path
  [ -d /opt/homebrew/opt/coreutils/bin ] && \
    export PATH="/opt/homebrew/opt/coreutils/bin:$PATH"

  # Add GNU's tar to path
  [ -x /opt/homebrew/opt/gnu-tar/libexec/gnubin/tar ] && \
    export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"

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
  export FNM_VERSION_FILE_STRATEGY=recursive
  if [ -n "$FNM_MULTISHELL_PATH" ] && [ -d "$FNM_MULTISHELL_PATH/bin" ]; then
    # Sub-shell: re-inject inherited multishell bin (PATH may have been reset)
    [[ ":$PATH:" != *":$FNM_MULTISHELL_PATH/bin:"* ]] && export PATH="$FNM_MULTISHELL_PATH/bin:$PATH"
  elif [ -f /opt/homebrew/bin/fnm ]; then
    eval "$(/opt/homebrew/bin/fnm env --use-on-cd --shell bash)"
  fi
}
[[ "$OSTYPE" == *'darwin'* ]] && mac_setup

# Linux specific
linux_setup() {
  # Default PATH for *NIX
  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  [ -f /etc/bashrc ] && . /etc/bashrc
  ulimit -n 1048576 >/dev/null 2>&1
  for DPATH in /opt/*-linux/bin; do
    [ -d "$DPATH" ] && PATH="$DPATH:$PATH"
  done
  # FNM
  export FNM_VERSION_FILE_STRATEGY=recursive
  if [ -n "$FNM_MULTISHELL_PATH" ] && [ -d "$FNM_MULTISHELL_PATH/bin" ]; then
    # Sub-shell (e.g. inside screen/tmux): linux_setup reset PATH above,
    # so re-inject the inherited multishell bin instead of re-running fnm env.
    [[ ":$PATH:" != *":$FNM_MULTISHELL_PATH/bin:"* ]] && export PATH="$FNM_MULTISHELL_PATH/bin:$PATH"
  elif [ -f $HOME/.local/share/fnm/fnm ]; then
    # Official installer location (curl -fsSL https://fnm.vercel.app/install | bash)
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd --shell bash)"
  elif [ -f $HOME/.local/bin/fnm ]; then
    eval "$($HOME/.local/bin/fnm env --use-on-cd --shell bash)"
  fi
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

###########################################################################
# Add $HOME Paths
###########################################################################
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi
if [ "$HOME" != "/" ]; then
  [ -d "$HOME/bin" ] && [[ ":$PATH:" != *":$HOME/bin:"* ]] && PATH="$HOME/bin:$PATH"
fi
###########################################################################

# load aliases and add user's bin to path
if [ "$(echo ~)" != "/" ]; then
  # Setup aliases on interactive terminal
  [ -t 0 ] && setup_aliases
  # Load .bash_common for interactive sessions
  [ -t 0 ] && [ ! "$__DF_BASH_COMMON" ] && [ -e ~/.bash_common ] && . ~/.bash_common
fi
