PATH="\
$(go env GOPATH)/bin:\
$HOME/.bin:\
$HOME/.local/bin:\
$HOME/.local/lib/python3.9/site-packages:\
$HOME/bin:\
/home/linuxbrew/.linuxbrew/bin:\
/usr/bin:\
/usr/sbin:\
/usr/share:\
/usr/lib/python3.9/site-packages:\
/usr/libexec:\
/usr/local/bin:\
$PATH
"

# zsh {{{

# spaceship {{{

ZSH_THEME="spaceship"
SPACESHIP_BATTERY_SYMBOL_CHARGING='⇡ '
SPACESHIP_BATTERY_SYMBOL_DISCHARGING='⇣ '
SPACESHIP_BATTERY_SYMBOL_FULL='• '

SPACESHIP_CHAR_SUFFIX=' '

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  # exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
# }}}

# plugins {{{

plugins=(
  bgnotify
  git
  zsh-256color
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ffffff,bold"
# autoload -U compinit && compinit
# }}}

# {{{

# setopt nomenucomplete
# setopt nolistambiguous
# setopt nobashautolist
# setopt rec_exact
setopt noautomenu

DISABLE_AUTO_TITLE="true"
HIST_STAMPS="mm/dd/yyyy"
export UPDATE_ZSH_DAYS=15
export ZSH="/home/prasriva/.oh-my-zsh"
export LANG=en_US.UTF-8

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Only one of these two can be enable at a time.
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# DISABLE_LS_COLORS="true"

# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# }}}

source $ZSH/oh-my-zsh.sh
# cmatrix -BC green
# }}}

# Misc. {{{

ZSH_AUTOSUGGEST_USE_ASYNC=1
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000
# }}}

# Exports{{{

export MANPAGER="nvim -c 'set ft=man' -"
export BRIDGE_JASMINE_TIMEOUT=600000
export KUBECONFIG="$HOME/c/auth/kubeconfig"
export GOPATH="$HOME/go"
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE='wayland'
export XDG_CURRENT_DESKTOP='sway'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --color auto'
export AWS_PROFILE='openshift-dev'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export EDITOR='nvim'
export MYBASHRC='~/.bashrc'
export MYZSHRC='~/.zshrc'
export MYVIMRC='~/.vimrc'
export GRIM_DEFAULT_DIR='~/Pictures'
# export WEATHER=$(curl -s wttr.in/Lucknow?format=4 | cut -d ':' -f2 | cut -c 2-)
#}}}

# Functions {{{

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

  DIR='c'                     # Cluster metadata directory
  USER='prasriva'
  CLUSTER_ID="$USER-$RANDOM"
  NAME='\[new\sname\shere\]'  # metadata > name value
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

alias log='oc login "https://api.$CLUSTER_ID.devcluster.openshift.com:6443" -u kubeadmin -p `cat "$DIR/auth/kubeadmin-password"`'
alias soc="source ./contrib/oc-environment.sh"
alias bb="./bin/bridge"
alias bat='bat --theme="Dracula" --style grid,numbers,changes'
alias dnf='sudo dnf'
alias hgrep='history | grep '
alias l='ls -p1'
alias la='ls -hlpAX'
alias ll='ls -pA1'
alias meet='/usr/libexec/xdg-desktop-portal -r & /usr/libexec/xdg-desktop-portal-wlr'
alias nv='nvim'
alias oi='openshift-install'
alias sshd='sudo /usr/sbin/sshd'
alias szr='source ~/.zshrc'
alias vif='nvim `fzf`'
alias vp="nvim --cmd 'profile start vimrc.profile' --cmd 'profile! file ~/.vimrc' -c"
alias vpn="nmcli con up uuid bd8183b3-3e15-4c20-a27b-5500873fd9ea && nmcli con"
alias vpnd="nmcli con down uuid bd8183b3-3e15-4c20-a27b-5500873fd9ea && nmcli con"
alias vr="nvim ~/.vimrc"
alias zr='nvim ~/.zshrc'
# }}}

