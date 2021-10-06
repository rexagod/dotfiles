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
$HOME/go/bin:\
/home/rexagod/.local/bin:\
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
export BAT_THEME='gruvbox-light'
export BROWSER='chromium'
export DEFAULT_RECIPIENT="rexagod@gmail.com"
export EDITOR='nvim'
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --color auto"
export FZF_DEFAULT_OPTS=""
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GO111MODULE="on"
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export KUBECONFIG="$HOME/openshift-cluster/auth/kubeconfig"
export LANG=en_US.UTF-8
export MANPAGER='nvim +Man!'
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export PAGER="bat --paging=auto --italic-text=always --color=always --number --theme ${BAT_THEME}"
export RANGER_LOAD_DEFAULT_RC="FALSE"
export UPDATE_ZSH_DAYS=15
export VIMRC='~/.config/nvim/init.vim'
export VIM_SESSION='~/.session.vim'
export VISUAL="nvim"
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

alias goland="/home/rexagod/.local/GoLand-2021.1/bin/goland.sh"
alias bat="bat --theme ${BAT_THEME} --style grid,numbers,changes"
alias bb="./bin/bridge"
alias c="clear"
alias gS="git stash"
alias gSp="git stash pop"
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
alias vif="fzf --preview-window=right:50% --preview=\"bat --theme ${BAT_THEME} --color always {}\" --bind \"enter:execute(nvim {})\""
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

  if [[ $1 == "d" ]]; then
    cd ~
    openshift-install destroy cluster --dir="$DIR"
    cd -
  elif [[ $1 == "ocs" ]]; then
    oc apply -f https://raw.githubusercontent.com/openshift/ocs-operator/master/deploy/deploy-with-olm.yaml
  elif [[ $1 == "odf" ]]; then
# {{{
    cat <<EOF | k apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  labels:
    odf-operator-internal: "true"
  name: odf-catalogsource
  namespace: openshift-marketplace
spec:
  sourceType: grpc
  image: quay.io/ocs-dev/odf-operator-catalog:latest
  displayName: OpenShift Data Foundation [Internal]
  publisher: Red Hat
EOF
# }}}
  else
    cd ~
    rm -rf "$DIR"
    mkdir "$DIR"
    cp .aws/"$CONF" "$DIR"/
    sed -i "s/$NAME/$CLUSTER_ID_STATIC/" "$DIR"/"$CONF"
    openshift-install create cluster --dir="$DIR"
    oc login "https://api.$CLUSTER_ID_STATIC.devcluster.openshift.com:6443" -u kubeadmin -p `cat "$DIR/auth/kubeadmin-password"`
    OCP_LOGIN_STRING="oc login \"https://api.$CLUSTER_ID_STATIC.devcluster.openshift.com:6443\" -u kubeadmin -p "`cat "$DIR/auth/kubeadmin-password"`
    echo $OCP_LOGIN_STRING > ~/.ocp-login-string.txt
    cd -
  fi
}
# }}}
# }}}
# Misc. {{{

# export WATCH_NAMESPACE="openshift-storage"
# export ROOK_CEPH_IMAGE="rook/ceph:v1.6.0.95.gf4cfc7a"
# export CEPH_IMAGE="ceph/daemon-base:latest-pacific"
# export NOOBAA_CORE_IMAGE="noobaa/noobaa-core:master-20210609"
# export NOOBAA_DB_IMAGE="centos/postgresql-12-centos7"
# export NOOBAA_IMAGE="noobaa/noobaa-operator:master-20210609"
# export ROOK_IMAGE="rook/ceph:v1.6.5-2.gb78358e"

if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# vim-gist plugin
# source ~/.local/vim-gist.token.bash

# krew
export PATH="${PATH}:${HOME}/.krew/bin"

# kubectl autocomplete
[[ /bin/kubectl ]] && source <(kubectl completion zsh)

# ocs-operator PR chores
alias make-ocs="make gen-latest-csv && make verify-latest-csv && make update-generated && make ocs-operator-ci"
# }}}
