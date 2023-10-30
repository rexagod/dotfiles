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
# Exports{{{

export ARCH="arm64"
export AWS_PROFILE='openshift-dev'
export BASHRC='~/.bashrc'
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
export MANPAGER="$EDITOR +Man!"
export OS="darwin"
export PAGER="bat"
export RANGER_LOAD_DEFAULT_RC="FALSE"
export UPDATE_ZSH_DAYS=15
export VIMRC='~/.config/nvim/init.vim'
export VIM_SESSION='~/.session.vim'
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"
export ZSHRC='~/.zshrc'
#}}}
# PATH {{{

export PATH="\
$GOBIN:\
$HOME/scripts:\
$HOME/.local/bin:\
/opt/homebrew/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/lib:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/sbin:\
/usr/share:\
/Users/rexagod/sdk/go1.20.6/bin/:\
" # $PATH intentially not included here.
# }}}
# Plugins {{{

plugins=(
  fzf
  git
  zsh-syntax-highlighting
  zsh-z
)

source $ZSH/oh-my-zsh.sh
# }}}
# Aliases{{{

alias c="clear"
alias gS="git stash"
alias gSa="git stash apply"
alias gSp="git stash pop"
alias hgrep="history | grep "
alias k="kubectl"
alias l="ls -1S"
alias la="ls -1Sa"
alias ll="ls -1lS"
alias ls="exa"
alias nv="$EDITOR"
alias rr="ranger"
alias szr="source $ZSHRC"
alias vif="fzf --preview-window=right:50% --preview=\"${PAGER} {}\" --bind \"enter:execute(${EDITOR} {})\""
alias vr="$EDITOR $VIMRC"
alias vrs="$EDITOR -S ~/.session.vim"
alias zr="$EDITOR $ZSHRC"
# }}}
# Functions {{{

cc () { # {{{
  DIR='.openshift-cluster'   # Cluster metadata directory
  USER='prasriva'            # RH username
  CONF='install-config.yaml' # Original config filename in .aws
  NAME='\[new\sname\shere\]' # Template for Cluster ID ('.metadata.name' in your $CONF)
  CLUSTER_ID="$USER-$RANDOM" # Cluster name = <Your RH id> + $RANDOM
  CLUSTER_ID_STATIC="$CLUSTER_ID"
  LOG="$HOME/.ocp-login-string.txt"

  if [[ $1 == "d" ]]; then
    cd ~
    openshift-install destroy cluster --dir="$DIR"
    cd -
  else
    cd ~
    rm -rf "$DIR"
    mkdir "$DIR"
    cp .aws/"$CONF" "$DIR"/
    gsed -i "s/$NAME/$CLUSTER_ID_STATIC/" "$DIR"/"$CONF"
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
# }}}
# Misc. {{{

force_color_prompt=yes
# kubectl {{{

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
source <(kubectl completion zsh)
compdef __start_kubectl k
# }}}
# k8s {{{

export PATH="/Users/rexagod/repositories/oss/kubernetes/third_party/etcd:${PATH}"
# }}}
# }}}

autoload -U compinit; compinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

