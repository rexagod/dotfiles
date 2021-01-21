# init{{{

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

PS1='\[\033[04;32m\]\W:\[\033[00m\]\$ '
unset color_prompt force_color_prompt

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_prompt=yes
    else
  color_prompt=
    fi
fi

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

HISTCONTROL=ignoreboth
HISTFILESIZE=1000
HISTSIZE=1000
shopt -s checkwinsize
shopt -s histappend

#shopt -s globstar

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#}}}

PATH="$HOME/.local/bin:$HOME/.bin:$PATH"

# Exports{{{

export XDG_CURRENT_DESKTOP='sway'
export AWS_PROFILE='openshift-dev'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export EDITOR='nvim'
export MYBASHRC='~/.bashrc'
export MYVIMRC='~/.vimrc'
export GRIM_DEFAULT_DIR='~/Pictures'
# export WEATHER=$(curl -s wttr.in/Lucknow?format=4 | cut -d ':' -f2 | cut -c 2-)
#}}}

# Functions {{{

vr() { #{{{
  cd /etc/dotfiles/
  if [[ -f .session.vim ]]; then
    nvim -S .session.vim
  else
    nvim -c 'source %' vimrc.vim
  fi
  cd - >> /dev/null
}
# }}}
# }}}

# Aliases{{{

alias apt-get='sudo apt-get'
alias apt='sudo apt'
alias bat='bat --theme="Dracula" --style grid,numbers,changes'
alias br='nvim ~/.bashrc'
alias dnf='sudo dnf'
alias hgrep='history | grep '
alias l='ls -p1'
alias la='ls -hlpAX'
alias ll='ls -pA1'
alias oi='openshift-install'
alias sbr='source ~/.bashrc'
alias sc='sudo systemctl'
alias v='nvim'
alias vp="nvim --cmd 'profile start vimrc.profile' --cmd 'profile! file ~/.vimrc' -c"
alias vpn="nmcli con up uuid bd8183b3-3e15-4c20-a27b-5500873fd9ea && nmcli con"
alias vpnd="nmcli con down uuid bd8183b3-3e15-4c20-a27b-5500873fd9ea && nmcli con"
alias yum='sudo yum'
# }}}

# cmatrix -BC green
