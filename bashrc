#
# bashrc is loaded on all bash sessions (interactive and non-interactive)
#

# Add GNU coreutils to path
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Add GNU's tar to path
[ -x /usr/local/opt/gnu-tar/libexec/gnubin/tar ] && \
  export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

# Add brew's path
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# Add "$HOME/bin" to path
[ "$HOME" ] && [ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Check if we have brew
which brew >/dev/null && export BREW_PREFIX="$(brew --prefix)"

# Setup and load nvm
[ "$BREW_PREFIX" ] && [ -f "$BREW_PREFIX/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/opt/nvm/nvm.sh"
