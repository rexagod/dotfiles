# Maintainer: @rexagod

# BASHRC {{{

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="mm/dd/yyyy"

alias ohmyzsh="nvim ~/.oh-my-zsh"
alias zshconfig="nvim ~/.zshrc"

export EDITOR='nvim'
export LANG=en_US.UTF-8
export UPDATE_ZSH_DAYS=15
export ZSH="/home/rexagod/.oh-my-zsh"

setopt noautomenu

# DISABLE_UNTRACKED_FILES_DIRTY="true"
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# }}}

# plugins {{{

plugins=(
  fzf
  git
  zsh-256color
  zsh-syntax-highlighting
  zsh-z
)

# }}}

# variables {{{

ZSH_THEME="nicoulaj"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fff,underline"
# }}}

source $ZSH/oh-my-zsh.sh

# Exports{{{

export AWS_PROFILE='openshift-dev'
export COC_GITHUB_USERS_TOKEN='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'
export DEFAULT_RECIPIENT="rexagod@gmail.com"
export EDITOR='nvim'
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --color auto'
export FZF_DEFAULT_OPTS=""
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GOBIN="$HOME/go/bin"
export GOOGLE_APPLICATION_CREDENTIALS="/home/rexagod/Downloads/contrib-k8s-478a21288ae7.json"
export GOPATH="$HOME/go"
export KUBECONFIG="$HOME/openshift-cluster/auth/kubeconfig"
export MANPAGER="nvim -c 'set ft=man' -"
export MOZ_ENABLE_WAYLAND=1
export BASHRC='~/.bashrc'
export VIM_SESSION='~/.session.vim'
export VIMRC='~/.config/nvim/init.vim'
export ZSHRC='~/.zshrc'
export PAGER="bat --theme=Dracula --paging=auto --italic-text=always --color=always --number"
export RANGER_LOAD_DEFAULT_RC="FALSE"
export VISUAL="nvim"
export XDG_SESSION_TYPE='wayland'
#}}}

# Functions {{{

ocs() { # {{{
  cd console
  wget https://raw.githubusercontent.com/afreen23/dev-setup/main/install-ocs.sh
  chmod +x install-ocs.sh
  ./install-ocs.sh
  rm install-ocs.sh
  cd - >> /dev/null
}
# }}}

# vr() { #{{{
#   cd /etc/dotfiles/
#   if [[ -f .session.vim ]]; then
#     nvim -S .session.vim
#   else
#     nvim -c 'source %' vimrc.vim
#   fi
#   cd - >> /dev/null
# }
# # }}}

cc () { # {{{

  export DIR='openshift-cluster'     # Cluster metadata directory
  USER='prasriva'
  export CLUSTER_ID="$USER-$RANDOM"
  NAME='new\sname\shere'  # metadata > name value
  CONF='install-config.yaml'  # Original config filename in .aws

  cd ~
  rm -rf "$DIR"
  mkdir "$DIR"
  cp .aws/"$CONF" "$DIR"/
  sed -i "s/$NAME/$CLUSTER_ID/" "$DIR"/"$CONF"
  openshift-install create cluster --dir="$DIR"
  oc login "https://api.$CLUSTER_ID.devcluster.openshift.com:6443" -u kubeadmin -p `cat "$DIR/auth/kubeadmin-password"`
  cd -
}
# }}}
# }}}

# Aliases{{{

alias bat="bat --theme=\"Dracula\" --style grid,numbers,changes"
alias bb="./bin/bridge"
alias c="clear"
alias gh="go help"
alias gS="git stash"
alias gSp="git stash pop"
alias hgrep="history | grep "
alias k="kubectl"
alias l="ls -p1"
alias la="ls -hlpAX"
alias ll="ls -pA1"
alias nv="nvim"
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
# }}}

# PATH {{{

export PATH="\
$HOME/go/bin:\
$HOME/.bin:\
$HOME/.local/bin:\
$HOME/bin:\
/home/linuxbrew/.linuxbrew/bin:\
/usr/bin:\
/usr/lib:\
/usr/local/bin:\
/usr/share:\
$GOPATH/bin:\
" # $PATH intentially not included here.
# }}}

# Misc. {{{

# # # K8s {{{

# GNUBINS="$(find /usr/local/opt -type d -follow -name gnubin -print)"
# for bindir in ${GNUBINS[@]}
# do
#   export PATH=$bindir:$PATH
# done

# # # }}}

# NVM {{{

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# }}}

if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi

HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
# }}}
