# Maintainer: @rexagod

# Options {{{

setopt noautomenu
unsetopt correct correct_all
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
# export GOPATH="$HOME/.g/go"
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
$HOME/.local/bin:\
$HOME/scripts:\
/opt/homebrew/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/lib:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/sbin:\
/usr/share:\
" # $PATH intentionally not included here.
# /Users/rexagod/goland-go/go1.22.4/bin:\
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
alias gvm="~/.g/bin/g"
alias hgrep="history | grep "
alias k="kubectl"
alias l="ls -1S"
alias la="ls -1Sa"
alias ll="ls -1lS"
# alias ls="exa" # exa broke
alias nv="$EDITOR"
alias rr="ranger"
alias szr="source $ZSHRC"
alias vif="fzf --preview-window=right:50% --preview=\"${PAGER} {}\" --bind \"enter:execute(${EDITOR} {})\""
alias vr="$EDITOR $VIMRC"
alias vrs="$EDITOR -S ~/.session.vim"
alias zr="$EDITOR $ZSHRC"
# }}}
# Functions {{{

# walk {{{
function lk {
  cd "$(walk "$@")"
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
# iterm2 {{{

autoload -U compinit; compinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# }}}
# gvm {{{

[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env"
# }}}
# dlv {{{
#compdef dlv
compdef _dlv dlv

# zsh completion for dlv                                  -*- shell-script -*-

__dlv_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_dlv()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16
    local shellCompDirectiveKeepOrder=32

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace keepOrder
    local -a completions

    __dlv_debug "\n========= starting completion logic =========="
    __dlv_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __dlv_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __dlv_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., dlv -n=<TAB>)
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
        __dlv_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __dlv_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __dlv_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __dlv_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __dlv_debug "No directive found.  Setting do default"
        directive=0
    fi

    __dlv_debug "directive: ${directive}"
    __dlv_debug "completions: ${out}"
    __dlv_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __dlv_debug "Completion received error. Ignoring completions."
        return
    fi

    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}
    local startIndex=$((${#activeHelpMarker}+1))
    local hasActiveHelp=0
    while IFS='\n' read -r comp; do
        # Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
        if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
            __dlv_debug "ActiveHelp found: $comp"
            comp="${comp[$startIndex,-1]}"
            if [ -n "$comp" ]; then
                compadd -x "${comp}"
                __dlv_debug "ActiveHelp will need delimiter"
                hasActiveHelp=1
            fi

            continue
        fi

        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab="$(printf '\t')"
            comp=${comp//$tab/:}

            __dlv_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    # Add a delimiter after the activeHelp statements, but only if:
    # - there are completions following the activeHelp statements, or
    # - file completion will be performed (so there will be choices after the activeHelp)
    if [ $hasActiveHelp -eq 1 ]; then
        if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
            __dlv_debug "Adding activeHelp delimiter"
            compadd -x "--"
            hasActiveHelp=0
        fi
    fi

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __dlv_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveKeepOrder)) -ne 0 ]; then
        __dlv_debug "Activating keep order."
        keepOrder="-V"
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

        __dlv_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __dlv_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __dlv_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __dlv_debug "Calling _describe"
        if eval _describe $keepOrder "completions" completions $flagPrefix $noSpace; then
            __dlv_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __dlv_debug "_describe did not find completions."
            __dlv_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __dlv_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __dlv_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_dlv" ]; then
    _dlv
fi
# }}}
# }}}
