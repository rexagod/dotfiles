# Maintainer: @rexagod

# Options {{{

setopt noautomenu
# }}}

# Variables {{{

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000
HIST_STAMPS="mm/dd/yyyy"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fff,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_THEME="nicoulaj"
# }}}

# PATH {{{

export PATH="\
$GOPATH/bin:\
$HOME/.bin:\
$HOME/.local/bin:\
$HOME/bin:\
$HOME/go/bin:\
/home/linuxbrew/.linuxbrew/bin:\
/usr/bin:\
/usr/lib:\
/usr/local/bin:\
/usr/share:\
" # $PATH intentially not included here.
# }}}

# Exports{{{

export AWS_PROFILE='openshift-dev'
export BASHRC='~/.bashrc'
export BROWSER='google-chrome-stable'
export COC_GITHUB_USERS_TOKEN='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'
export DEFAULT_RECIPIENT="rexagod@gmail.com"
export EDITOR='nvim'
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --color auto"
export FZF_DEFAULT_OPTS=""
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GOBIN="$HOME/go/bin"
export GOOGLE_APPLICATION_CREDENTIALS="/home/rexagod/Downloads/contrib-k8s-478a21288ae7.json"
export GOPATH="$HOME/go"
export IMAGE_TAG='latest'
export KUBECONFIG="$HOME/openshift-cluster/auth/kubeconfig"
export LANG=en_US.UTF-8
export MANPAGER="nvim -c 'set ft=man' -"
export MOZ_ENABLE_WAYLAND=1
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export PAGER="bat --paging=auto --italic-text=always --color=always --number --theme gruvbox-dark"
export RANGER_LOAD_DEFAULT_RC="FALSE"
export REGISTRY_NAMESPACE='rexagod'
export UPDATE_ZSH_DAYS=15
export VIMRC='~/.config/nvim/init.vim'
export VIM_SESSION='~/.session.vim'
export VISUAL="nvim"
export XDG_SESSION_TYPE='wayland'
export ZSH="/home/rexagod/.oh-my-zsh"
export ZSHRC='~/.zshrc'
#}}}

# Plugins {{{

plugins=(
  fzf
  git
  zsh-256color
  zsh-syntax-highlighting
  zsh-z
)

source $ZSH/oh-my-zsh.sh
# }}}

# Aliases{{{

alias bat="bat --theme=\"Dracula\" --style grid,numbers,changes"
alias bb="./bin/bridge"
alias c="clear"
alias gS="git stash"
alias gSp="git stash pop"
alias gh="go help"
alias hgrep="history | grep "
alias k="kubectl"
alias ls="lsd"
alias l="ls -1Sh"
alias la="ls -1SAh"
alias ll="ls -1lSh"
alias nv="nvim"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias pacman="sudo pacman"
alias rr="ranger"
alias soc="source ./contrib/oc-environment.sh"
alias sshd="sudo /usr/sbin/sshd"
alias szr="source ~/.zshrc"
alias vi="nvim"
alias vif="fzf --preview-window=right:50% --preview=\"bat --color always {}\" --bind \"enter:execute(nvim {})\""
alias vpn="nmcli con up id \"1 - Red Hat Global VPN\" --ask"
alias vpnd="nmcli con down id \"1 - Red Hat Global VPN\" --ask"
alias vr="nvim ${VIMRC}"
alias vrs="nvim -S ${VIM_SESSION}"
alias zr="nvim ${ZSHRC}"
alias zshconfig="nvim ~/.zshrc"
# }}}

# Functions {{{

cc () { # {{{

  DIR='.openshift-cluster'   # Cluster metadata directory
  USER='prasriva'            # RH username
  NAME='new\sname\shere'     # Template for Cluster ID
  CONF='install-config.yaml' # Original config filename in .aws
  CLUSTER_ID="$USER-$RANDOM" # Cluster name = <Your RH id> + $RANDOM
  CLUSTER_ID_STATIC="$CLUSTER_ID"

  cd ~
  rm -rf "$DIR"
  mkdir "$DIR"
  cp .aws/"$CONF" "$DIR"/
  sed -i "s/$NAME/$CLUSTER_ID_STATIC/" "$DIR"/"$CONF"
  openshift-install create cluster --dir="$DIR"
  oc login "https://api.$CLUSTER_ID_STATIC.devcluster.openshift.com:6443" -u kubeadmin -p `cat "$DIR/auth/kubeadmin-password"`
  export OCP_LOGIN_STRING="oc login \"https://api.$CLUSTER_ID_STATIC.devcluster.openshift.com:6443\" -u kubeadmin -p "`cat "$DIR/auth/kubeadmin-password"`
  echo $OCP_LOGIN_STRING
  cd -
}
# }}}
# }}}

# Misc. {{{

export WATCH_NAMESPACE="openshift-storage"                                                                                                        
export ROOK_CEPH_IMAGE="rook/ceph:v1.6.0.95.gf4cfc7a"                                                                                             
export CEPH_IMAGE="ceph/daemon-base:latest-pacific"                                                                                               
export NOOBAA_CORE_IMAGE="noobaa/noobaa-core:master-20210609"                                                                                     
export NOOBAA_DB_IMAGE="centos/postgresql-12-centos7"

if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# vim-gist plugin
source ~/.local/vim-gist.token.bash

pfetch
# }}}
