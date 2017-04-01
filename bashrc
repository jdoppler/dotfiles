###############################################################################
#
#   .bashrc/.profile
#

#-----------------------------------------------------------------------------
# SOURCE GLOBAL DEFINITIONS
#-----------------------------------------------------------------------------
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# different colors for specific filetypes
if [ -x /usr/bin/dircolors ]; then
    # test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    eval "$(dircolors -b)"
fi

# unmap <C-s>
[[ $- == *i* ]] && stty stop undef

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

#-----------------------------------------------------------------------------
# HISTORY
#-----------------------------------------------------------------------------
# append to the history file, don't overwrite it
shopt -s histappend
export HISTSIZE=100000
export PROMPT_COMMAND="history -a; history -n;"

#-----------------------------------------------------------------------------
# GIT
#-----------------------------------------------------------------------------
alias gru='git remote update && git status'
alias git_get_remote_branch='for remote in $(git branch -r | grep -v master); do git checkout --track $remote; done; git checkout master'

# git auto-completion & shell promt
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE= #"branch"
GIT_PS1_SHOWUPSTREAM= #"auto git"

#-----------------------------------------------------------------------------
# COLORS
#-----------------------------------------------------------------------------
export CLICOLOR=1
# export GREEN='\[\033[0;32m\]'
# export BLUE='\[\033[0;34m\]'
# export LIGHTCYAN='\[\033[0;36m\]'
# export WHITE='\[\033[1;37m\]'
# export DEFAULT='\[\033[0m\]'

# test if using interactive shell
if [[ $- == *i* ]]; then
    export GREEN=$(tput setaf 2)
    export BLUE=$(tput setaf 4)
    export CYAN=$(tput setaf 6)
    export LIGHTCYAN=$(tput setaf 6)
    export WHITE=$(tput setaf 7)
    export DEFAULT=$(tput sgr0)
fi

#-----------------------------------------------------------------------------
# VI(M)
#-----------------------------------------------------------------------------
export EDITOR='vi'

#-----------------------------------------------------------------------------
# FUNCTIONS
#-----------------------------------------------------------------------------
# calculator for the commandline
function calc {
    python -c "from numpy import *; print ${1}"
}
export -f calc

# loop through items, echo item name and execute cat
function forcat {
    for i in "${@}"; do
        echo $i; cat $i; echo
    done
}
export -f forcat

# taken from http://blog.thelinuxkid.com/2013/06/automatically-start-tmux-on-ssh.html
function use_tmux {
    MOTD="/etc/motd"
    if [[ -z "$TMUX" ]]; then
        tmux has-session &> /dev/null
        if [ $? -eq 1 ]; then
            exec tmux -2 new
            exit
        else
            exec tmux -2 attach
            exit
        fi
    fi
    if [[ -f "$MOTD" ]]; then
        cat "$MOTD"
    fi
}
export -f use_tmux

#-----------------------------------------------------------------------------
# COMMON ALIASES
#-----------------------------------------------------------------------------
if [ "$(uname)" == "Darwin" ]; then
    # alias
    alias ls='ls -GF'
    alias vi='/usr/local/bin/vim'
    alias vim='/usr/local/bin/vim'
    alias vimdiff='/usr/local/bin/vimdiff'
elif [ "$(uname)" == "Linux" ]; then
    # main code directory
    export PYTHONUNBUFFERED=1
    # alias
    alias ls='ls -GF --color=auto'
fi

alias ip="ipython --pylab=qt5 --TerminalInteractiveShell.editing_mode=vi"
alias grep='grep --color=auto'

#-----------------------------------------------------------------------------
# PATH
#-----------------------------------------------------------------------------
PATH=$PATH:$HOME/bin
export PATH

#-----------------------------------------------------------------------------
# PS1 prompt
#-----------------------------------------------------------------------------
export PS1="\[${GREEN}\]\u\[${WHITE}\]@\[${GREEN}\]\h\[${WHITE}\]:\[${LIGHTCYAN}\]\w\[${WHITE}\]\$(__git_ps1) \[${GREEN}\]\$ \[${DEFAULT}\]"

#-----------------------------------------------------------------------------
# MACHINE SPECIFIC SETTINGS
#-----------------------------------------------------------------------------
case $(hostname) in
    "jd")
        # brew binaries before system defaults
        PATH=$HOME/.local/bin:/usr/local/bin:$PATH

        # alias
        alias ipn='jupyter-notebook --browser=Safari'

        # iTerm2 colors
        export TERM=xterm-256color
esac
