# linux bin
D=/opt/pcel-linux/bin && [ -d "$D" ] && export PATH="$D:$PATH"
D=/usr/local/bin && [ -d "$D" ] && export PATH="$D:$PATH"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f /opt/homebrew/bin/fnm ] && eval "$(/opt/homebrew/bin/fnm env --use-on-cd)"
