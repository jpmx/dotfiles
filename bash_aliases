#!/usr/bin/env bash

################################
# Aliases
################################
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
