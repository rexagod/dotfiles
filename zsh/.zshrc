# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
/sbin:\
/usr/bin:\
/usr/lib:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/sbin:\
/usr/share:\
/home/linuxbrew/.linuxbrew/opt/node@14/bin:\
" # $PATH intentially not included here.
# }}}
# Exports{{{

export KUBECONFIG="$HOME/.openshift-cluster/auth/kubeconfig"
export AWS_PROFILE='openshift-dev'
export BASHRC='~/.bashrc'
export BAT_THEME='ansi'
export BROWSER='firefox'
export DEFAULT_RECIPIENT="rexagod@gmail.com"
export EDITOR='nvim'
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --color auto"
export FZF_DEFAULT_OPTS=""
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GOBIN="$HOME/go/bin/"
export GOPATH="$HOME/go/"
export LANG=en_US.UTF-8
export MANPAGER="${EDITOR} +Man!"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export PAGER="bat --paging=auto --italic-text=always --color=always --number --theme ${BAT_THEME}"
export RANGER_LOAD_DEFAULT_RC="FALSE"
export REGISTRY_NAMESPACE="rexagod"
export TMUXRC='~/.config/tmux/tmux.conf'
export UPDATE_ZSH_DAYS=15
export VIMRC='~/.config/nvim/init.vim'
export VIM_SESSION='~/.session.vim'
export VISUAL="${EDITOR}"
export ZSH="/home/rexagod/.oh-my-zsh"
export ZSHRC='~/.zshrc'
#}}}
# Plugins {{{

plugins=(
  fzf
  git
  zsh-syntax-highlighting
  zsh-z
)

# zsh-256color
# fzf-tab {{{

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# }}}

source $ZSH/oh-my-zsh.sh
# }}}
# Aliases{{{

alias bat="bat --theme ${BAT_THEME} --style grid,numbers,changes"
alias bb="./bin/bridge"
alias c="clear"
alias dnf="sudo dnf"
alias gS="git stash"
alias gSp="git stash pop"
alias hgrep="history | grep "
alias k="kubectl"
alias l="ls -1S"
alias la="ls -1SA"
alias ll="ls -1lS"
alias nv="${EDITOR}"
alias odc="ocm describe cluster"
alias rr="ranger"
alias soc="source ./contrib/oc-environment.sh"
alias sshd="sudo /usr/sbin/sshd"
alias szr="source ~/.zshrc"
alias vif="fzf --preview-window=right:50% --preview=\"bat --theme ${BAT_THEME} --color always {}\" --bind \"enter:execute(${EDITOR} {})\""
alias vr="${EDITOR} ${VIMRC}"
alias zr="${EDITOR} ${ZSHRC}"
# }}}
# Functions {{{

osd () {
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
  elif [[ $1 == "build-ocs" ]]; then
    # Make targets and push images {{{
    make ocs-operator && 
      podman push quay.io/${OCS_REGISTRY_NAMESPACE}/ocs-operator:${OCS_IMAGE_TAG} && \
      make gen-latest-csv && \
      make operator-bundle && \
      podman push quay.io/${OCS_REGISTRY_NAMESPACE}/ocs-operator-bundle:${OCS_IMAGE_TAG} && \
      make operator-index && \
      podman push quay.io/${OCS_REGISTRY_NAMESPACE}/ocs-operator-index:${OCS_IMAGE_TAG}
    # }}}
  elif [[ $1 == "deploy-ocs" ]]; then
# CatalogSource Spec {{{
k create ns openshift-storage
cat <<EOF | k apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: ${OCS_SOURCE}
  namespace: openshift-marketplace
spec:
  sourceType: grpc
  image: quay.io/${OCS_REGISTRY_NAMESPACE}/ocs-operator-index:${OCS_IMAGE_TAG}
  displayName: OpenShift Container Storage
  publisher: Red Hat
---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ocs-dev-subscription
  namespace: openshift-storage
spec:
  channel: stable-4.9
  name: ocs-operator
  source: ${OCS_SOURCE}
  sourceNamespace: openshift-marketplace
EOF
# }}}
  elif [[ $1 == "odf" ]]; then
# CatalogSource Spec {{{
cat <<EOF | k apply -f -
---
apiVersion: v1
kind: Namespace
metadata:
  labels:
    openshift.io/cluster-monitoring: "true"
  name: openshift-storage
spec: {}
---
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: openshift-storage-operatorgroup
  namespace: openshift-storage
spec:
  targetNamespaces:
  - openshift-storage
---
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  labels:
    ocs-operator-internal: 'true'
  name: redhat-operators
  namespace: openshift-marketplace
spec:
  displayName: Openshift Data Foundation
  icon:
    base64data: ''
    mediatype: ''
  image: quay.io/rhceph-dev/ocs-registry:latest-stable-4.11
  priority: 100
  publisher: Red Hat
  sourceType: grpc
  updateStrategy:
    registryPoll:
      interval: 15m
EOF
# }}}
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
# }}}
# Misc. {{{

# broot {{{

source /home/rexagod/.config/broot/launcher/bash/br
# }}}
# nvm {{{

export PATH="/home/linuxbrew/.linuxbrew/opt/go@1.17/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# }}}
# operator-sdk {{{

#compdef _operator-sdk operator-sdk

# zsh completion for operator-sdk                         -*- shell-script -*-

__operator-sdk_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_operator-sdk()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
    local -a completions

    __operator-sdk_debug "\n========= starting completion logic =========="
    __operator-sdk_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __operator-sdk_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __operator-sdk_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., operator-sdk -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __operator-sdk_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __operator-sdk_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __operator-sdk_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __operator-sdk_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __operator-sdk_debug "No directive found.  Setting do default"
        directive=0
    fi

    __operator-sdk_debug "directive: ${directive}"
    __operator-sdk_debug "completions: ${out}"
    __operator-sdk_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __operator-sdk_debug "Completion received error. Ignoring completions."
        return
    fi

    while IFS='\n' read -r comp; do
        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab=$(printf '\t')
            comp=${comp//$tab/:}

            __operator-sdk_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __operator-sdk_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __operator-sdk_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subDir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __operator-sdk_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __operator-sdk_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __operator-sdk_debug "Calling _describe"
        if eval _describe "completions" completions $flagPrefix $noSpace; then
            __operator-sdk_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __operator-sdk_debug "_describe did not find completions."
            __operator-sdk_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __operator-sdk_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __operator-sdk_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_operator-sdk" ]; then
	_operator-sdk
fi
# }}}
# g {{{

export GOPATH="$HOME/go/"; export GOROOT="$GOPATH/sdk/go1.17"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
alias gvm=~/go/bin/g
# }}}
# ranger {{{

if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# }}}
# kubectl {{{
source <(kubectl completion zsh)
compdef __start_kubectl k
# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# }}}
# }}}

autoload -U compinit; compinit

