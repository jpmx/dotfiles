export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# .dotfiles auto update
if [ $((RANDOM % 10)) -eq 0 ] && [ ! -f /.dockerenv ] && [ -x ~/.dotfiles/auto_update ]; then
  ( nohup ~/.dotfiles/auto_update >/dev/null 2>&1 & ) >/dev/null 2>&1
fi

# install and load zsh + plugins
[ ! -d $ZSH ] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
D="$ZSH/custom/plugins/zsh-syntax-highlighting" && [ ! -d "$D" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting "$D"
D="$ZSH/custom/plugins/zsh-completions" && [ ! -d "$D" ] && git clone https://github.com/zsh-users/zsh-completions "$D"
D="$ZSH/custom/plugins/zsh-autosuggestions" && [ ! -d "$D" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$D"
plugins=(git jump colored-man-pages zsh-autosuggestions zsh-completions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

#######################################################################################################
# Custom prompt to identify local vs remote host
#######################################################################################################
DEV="" && [[ "$OSTYPE" == *'darwin'* ]] && DEV=true
[ ! "$DEV" ] && [ -f /proc/version ] && grep -q '@Microsoft.com' /proc/version && DEV=true
if [ "$DEV" ]; then
    export PS1='%{$fg[cyan]%}[$USER@%m]%{$reset_color%} %(?:%{%}➜ :%{%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
else
    export PS1='%{$fg[yellow]%}[$USER@%m]%{$reset_color%} %(?:%{%}➜ :%{%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
fi
#######################################################################################################

# env and paths
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH
# pipx
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
# nvm
if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# :: Aliases and functions
alias l="ls"
alias ll="ls -ltr"
alias m="mark"
alias um="unmark"
alias j="jump"
alias c="clear"
alias cls="clear"
