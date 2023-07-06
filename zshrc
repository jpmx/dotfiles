export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE=true

# .dotfiles auto update
if [ $((RANDOM % 10)) -eq 0 ] && [ ! -f /.dockerenv ] && [ -x ~/.dotfiles/auto_update ]; then
  ( nohup ~/.dotfiles/auto_update >/dev/null 2>&1 & ) >/dev/null 2>&1
fi

# install and load zsh + plugins
[ ! -d $ZSH ] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
D="$ZSH/custom/plugins/fast-syntax-highlighting" && [ ! -d "$D" ] && git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$D"
D="$ZSH/custom/plugins/zsh-completions" && [ ! -d "$D" ] && git clone https://github.com/zsh-users/zsh-completions "$D"
D="$ZSH/custom/plugins/zsh-autosuggestions" && [ ! -d "$D" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$D"
plugins=(git jump colored-man-pages zsh-autosuggestions zsh-completions fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
unsetopt share_history
setopt no_share_history

#######################################################################################################
# Custom prompt to identify local vs remote host
#######################################################################################################
# OS X Specific
mac_setup() {
  # add vscode to gitconfig
  ! grep -q 'code --wait --new-window' ~/.gitconfig && git config --global core.editor 'code --wait --new-window'
  if ! grep -q 'tool = vscode' ~/.gitconfig; then
      git config --global diff.tool vscode
      git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
      git config --global merge.tool vscode
      git config --global mergetool.vscode.cmd 'code --wait $MERGED'
  fi

  # MacOS / Homebrew aliases
  if which pyenv >/dev/null 2>&1; then
      eval "$(pyenv init -)"
  else
      which brew >/dev/null 2>&1 && echo "(dotfiles): Installing pyenv" && brew install pyenv && eval "$(pyenv init -)" || :
  fi
  CMD_NODE=$(ls /opt/homebrew/opt/node@*/bin/node | sort -nr | head -1) 2>/dev/null
  [ "$CMD_NODE" ] && export PATH="$(dirname "$CMD_NODE")":$PATH

  return 0
}

linux_setup() {
    if [ -d "$HOME/.pyenv" ]; then
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    fi
}

DEV="" && [[ "$OSTYPE" == *'darwin'* ]] && mac_setup && DEV=true
[[ "$OSTYPE" == *'linux'* ]] && linux_setup
[ ! "$DEV" ] && [ -f /proc/version ] && grep -q '@Microsoft.com' /proc/version && DEV=true
if [ "$DEV" ]; then
    export PS1='%{$fg[green]%}$USER@%m:%{$reset_color%}%{$fg[yellow]%}%~%{$reset_color%} $(git_prompt_info)'$'\n''$ '
else
    export PS1='%{$fg[yellow]%}$USER@%m:%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'$'\n''$ '
fi
#######################################################################################################

# HOME bin paths
D="$HOME/bin" && [ -d "$D" ] && export PATH="$D:$PATH"
D="$HOME/.local/bin" && [ -d "$D" ] && export PATH="$D:$PATH"

# :: Aliases and functions
alias l="ls"
alias ll="ls -ltr"
alias m="mark"
alias um="unmark"
alias j="jump"
alias c="clear"
alias cls="clear"
