## Path
CONFIG_PATH=$HOME/.config
PATH="$HOME/.local/bin:$PATH"

## OMZ
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='simple'
plugins=(git tmux)
ZSH_TMUX_AUTOSTART=true
source $ZSH/oh-my-zsh.sh

## Alias
alias vi='nvim'
alias rm='trash'
alias ls="${aliases[ls]} --group-directories-first"
alias pacman='sudo pacman'
alias svi='sudo nvim'
alias systemctl='sudo systemctl'
alias journalctl='sudo journalctl'
alias ll='ls -lah'
alias l='ls -h'
alias python='python3'
cd() { builtin cd "$@"; l; }

update() {
  pacman -Qdtq | ifne sudo pacman --noconfirm -Rns -
  pacman --noconfirm -Syu
  yay --noconfirm -Sua

  ~/.tmux/plugins/tpm/bin/update_plugins all

  python ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer --ts-completer --quiet

  omz update

  sudo trash-empty -f --all-users 100
}

mkvenv() {
  python -m venv $CONFIG_PATH/venv/$1
  source $CONFIG_PATH/venv/$1/bin/activate
}

venv() {
  source $CONFIG_PATH/venv/$1/bin/activate
}

x() {
  echo $(($1))
}
