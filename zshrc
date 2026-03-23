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

mkpasswd() {
  local user=$1
  if [[ -z "$user" ]]; then
    echo "Usage: $0 [USERNAME]"
    return 1
  fi

  echo -n "Enter password: "
  read -rs pass
  echo ""
  echo -n "Confirm password: "
  read -rs pass2
  echo ""
  if [[ "$pass" != "$pass2" ]]; then
    echo "Missmatched?!?!"
    return 1
  fi

  local hash=$(openssl passwd -6 "$pass")
  echo "${user}:${hash}"
}
