# linux bin
for P in /opt/*-linux/bin; do export PATH="$P:$PATH"; done 2>/dev/null

# env and paths
[ -d /usr/local/bin ]  && export PATH=/usr/local/bin:$PATH
[ -d $HOME/bin ] && export PATH=${HOME}/bin:$PATH

# pipx
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
