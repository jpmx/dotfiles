# linux bin
D=/opt/pcel-linux/bin && [ -d "$D" ] && export PATH="$D:$PATH"

# env and paths
D=/usr/local/bin && [ -d "$D" ] && export PATH="$D:$PATH"
D=$HOME/bin && [ -d "$D" ] && export PATH="$D:$PATH"
D=$HOME/.local/bin && [ -d "$D" ] && export PATH="$D:$PATH"
