#!/usr/bin/env bash

#
# bash_profile is used ONLY on interactive sessions
#

# Load bash_profile once
[ "$__DF_BASH_PROFILE_LOADED" ] && return 0
__DF_BASH_PROFILE_LOADED=true

# Load bashrc
[ ! "$__DF_BASHRC_LOADED" ] && [ -e "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Load .bash_apikeys if exists
[ -e "$HOME/.bash_apikeys" ] && . "$HOME/.bash_apikeys"

# Load bash completion
if [ "$BREW_PREFIX" ] && [ -e "$BREW_PREFIX/etc/bash_completion" ]; then
 . "$BREW_PREFIX/etc/bash_completion"
fi

# Add GNU's man pages to MANPATH
if [ "$BREW_PREFIX" ] && [ -d "$BREW_PREFIX/opt/coreutils/libexec/gnuman" ]; then
  export MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnuman"
fi

################################
# Env mods
################################

# Enable terminal colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# stop checking for mail
unset MAILCHECK

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Setup locale
export LC_CTYPE=en_US.UTF-8

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoredups

# Default editor
export EDITOR="vim"
export GIT_EDITOR="vim"

# -- raw ps1
# export PS1="[\u@BSD-Unix \W\]# "
# -- colored ps1
# export PS1="\e[32m[\u@BSD-Unix \e[33m\W\\e[32m]# \e[0m"
# -- tell bash that the sequence of characters should not be counted in the prompt's length
# -- using \[ and \]
if [[ "$OSTYPE" == *'darwin'* ]]; then
  export PS1='\[\e[32m\][\u@BSD-Unix \[\e[33m\]\W\[\e[32m\]]# \[\e[0m\]'
else
  export PS1='\[\e[0;33m\][\u@\h \[\e[1;33m\]\W\[\e[0;33m\]]# \[\e[0m\]'
fi

# Load git-prompt
if [ -e "$HOME/.dotfiles/packages/git-completion/git-prompt.sh" ] && which git >/dev/null 2>&1; then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWSTASHSTATE=1
  . "$HOME/.dotfiles/packages/git-completion/git-prompt.sh"
  if [[ "$OSTYPE" == *'darwin'* ]]; then
    export PROMPT_COMMAND='__git_ps1 "\[\e[32m\][\u@BSD-Unix\[\e[0m\]" " \[\e[33m\]\W\[\e[32m\]]# \[\e[0m\]"'
  else
    export PROMPT_COMMAND='__git_ps1 "\[\e[0;33m\][\u@\h\[\e[0m\]" " \[\e[1;33m\]\W\[\e[0;33m\]]# \[\e[0m\]"'
  fi
fi

# Load z
if [ -e "$HOME/.dotfiles/packages/z/z.sh" ]; then
  . "$HOME/.dotfiles/packages/z/z.sh"
fi

################################
# Terminal Hacks
################################

# Increase terminal baudrate to max
[ "$SSH_TTY" ] && stty -F $SSH_TTY 115200 >/dev/null 2>&1 || stty 115200 >/dev/null 2>&1

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob >/dev/null 2>&1

# Bash includes filenames beginning with a . in the results of filename expansion
shopt -s dotglob >/dev/null 2>&1

# Bash will not attempt to search the PATH for possible completions
# when completion is attempted on an empty line
shopt -s no_empty_cmd_completion >/dev/null 2>&1

# Autocorrect typos in path names when using `cd`
shopt -s cdspell  >/dev/null 2>&1
shopt -s dirspell >/dev/null 2>&1

# If necessary, updates the values of LINES and COLUMNS if window size changed
shopt -s checkwinsize >/dev/null 2>&1

# If this is set, Bash checks that a command found in the hash table exists
# before trying to execute it. If a hashed command no longer exists,
# a normal path search is performed
shopt -s checkhash >/dev/null 2>&1

# Enable 'autocd'   - '**/qux' will enter './foo/bar/baz/qux'
# Enable 'globstar' - Recursive globbing, e.g. 'echo **/*.txt'
shopt -s globstar >/dev/null 2>&1
shopt -s autocd >/dev/null 2>&1

# append to the history file, don't overwrite it
shopt -s histappend >/dev/null 2>&1

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" "$HOME/.ssh/config" | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

################################
# Aliases
################################
CA="--color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls $CA"
alias ll="ls -l"
alias lld="ls -lUd .*/ */"
alias l="ls -CF"
alias l.="ls -lA"
alias la="ls -A"
alias grep="grep $CA"
alias fgrep="fgrep $CA"
alias egrep="egrep $CA"


################################
# Custom user's paths
################################


