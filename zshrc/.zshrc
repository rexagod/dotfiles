# Maintainer: @rexagod

# Options {{{

setopt noautomenu
# }}}
# Variables {{{

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000
HIST_STAMPS="mm/dd/yyyy"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_THEME="darkblood"
# }}}
# PATH {{{

export PATH="\
$GOBIN:\
/bin:\
/home/linuxbrew/.linuxbrew/bin:\
/home/rexagod/.local/bin:\
/home/rexagod/scripts:\
/sbin:\
/usr/bin:\
/usr/lib:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/sbin:\
/usr/share:\
" # $PATH intentially not included here.
# }}}
# Exports{{{

export AWS_PROFILE='openshift-dev'
export BASHRC='~/.bashrc'
export BROWSER='firefox'
export DEFAULT_RECIPIENT="rexagod@gmail.com"
export EDITOR='nvim'
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --color auto"
export FZF_DEFAULT_OPTS="--bind shift-up:preview-up,shift-down:preview-down,ctrl-u:preview-page-up,ctrl-d:preview-page-down"
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export KUBECONFIG="$HOME/.openshift-cluster/auth/kubeconfig"
export LANG=en_US.UTF-8
export MANPAGER="${EDITOR} +Man!"
export PAGER="bat"
export RANGER_LOAD_DEFAULT_RC="FALSE"
export TMUXRC='~/.config/tmux/tmux.conf'
export UPDATE_ZSH_DAYS=15
export VIMRC='~/.config/nvim/init.vim'
export VIM_SESSION='~/.session.vim'
export VISUAL="${EDITOR}"
export XDG_CONFIG_HOME="/home/rexagod/.config"
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

alias c="clear"
alias dnf="sudo dnf"
alias gS="git stash"
alias gSp="git stash pop"
alias hgrep="history | grep "
alias k="kubectl"
alias l="ls -1S"
alias la="ls -1Sa"
alias ll="ls -1lS"
alias nv="${EDITOR}"
alias rr="ranger"
alias sshd="sudo /usr/sbin/sshd"
alias szr="source ~/.zshrc"
alias vif="fzf --preview-window=right:50% --preview=\"${PAGER} {}\" --bind \"enter:execute(${EDITOR} {})\""
alias vr="${EDITOR} ${VIMRC}"
alias vrs="${EDITOR} -S ~/.session.vim"
alias zr="${EDITOR} ${ZSHRC}"

alias ls="exa"
# }}}
# Functions {{{

osd () { # {{{
    if [ -z "$1" ]; then
        echo "no cluster identifier provided, exiting"
        return 1
    fi
    cluster="$(ocm describe cluster $1 | grep -w 'ID' | awk 'NR==1{print $2}')"
    password="$(ocm get /api/clusters_mgmt/v1/clusters/$cluster/credentials | jq -r .admin.password)"
    url="$(ocm describe cluster $cluster | grep -w 'Console URL' | awk 'NR==1{print $3}')"
    uri="$(ocm describe cluster $cluster | grep -w 'API URL' | awk 'NR==1{print $3}')"
    echo "oc login ${uri} -u kubeadmin -p ${password}"
    echo "${url}"
}
# }}}
cc () { # {{{
  DIR='.openshift-cluster'   # Cluster metadata directory
  USER='prasriva'            # RH username
  CONF='install-config.yaml' # Original config filename in .aws
  NAME='\[new\sname\shere\]' # Template for Cluster ID ('.metadata.name' in your $CONF)
  CLUSTER_ID="$USER-$RANDOM" # Cluster name = <Your RH id> + $RANDOM
  CLUSTER_ID_STATIC="$CLUSTER_ID"
  LOG='/home/rexagod/.ocp-login-string.txt'

  export OCS_REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE:-rexagod} OCS_IMAGE_TAG=${IMAGE_TAG:-latest} OCS_SOURCE=${OCS_SOURCE:-redhat-operators}

  if [[ $1 == "d" ]]; then
    cd ~
    openshift-install destroy cluster --dir="$DIR"
    cd -
  else
    cd ~
    rm -rf "$DIR"
    mkdir "$DIR"
    cp .aws/"$CONF" "$DIR"/
    sed -i "s/$NAME/$CLUSTER_ID_STATIC/" "$DIR"/"$CONF"
    ${OSI_PATH:-"openshift-install"} create cluster --dir="$DIR"
    oc login "https://api.$CLUSTER_ID_STATIC.devcluster.openshift.com:6443" -u kubeadmin -p `cat "$DIR/auth/kubeadmin-password"`
    OCP_LOGIN_STRING="oc login \"https://api.$CLUSTER_ID_STATIC.devcluster.openshift.com:6443\" -u kubeadmin -p "`cat "$DIR/auth/kubeadmin-password"`
    echo "\n" >> $LOG
    echo $OCP_LOGIN_STRING >> $LOG
    echo "https://console-openshift-console.apps.$CLUSTER_ID_STATIC.devcluster.openshift.com" >> $LOG
    cd -
  fi
}
# }}}
gerrit_stash_as () { # {{{
  GERRIT_FILE="/home/rexagod/Documents/gerrit/gerrit.py"
  GERRIT_ARCHIVE="/home/rexagod/Documents/gerrit/archives"
  cp "${GERRIT_FILE}" "${GERRIT_ARCHIVE}/$1.py" && \
  rm "${GERRIT_FILE}" && \
  touch "${GERRIT_FILE}" && \
  clear
}
# }}}
# }}}
# Misc. {{{

force_color_prompt=yes
ulimit -s 2000123
# g {{{

export GOPATH="$HOME/go/"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
alias gvm=~/go/bin/g
# }}}
# kubectl {{{
source <(kubectl completion zsh)
compdef __start_kubectl k

# krew {{{
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# }}}
# }}}
# }}}

autoload -U compinit; compinit
