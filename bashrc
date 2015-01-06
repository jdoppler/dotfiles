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

# unmap <C-s>
stty stop undef

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

# git auto-completion & shell promt
source ~/.git-completion.bash
source ~/.git-prompt.sh

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
export GREEN='\[\033[0;32m\]'
export BLUE='\[\033[0;34m\]'
export LIGHTCYAN='\[\033[0;36m\]'
export WHITE='\[\033[1;37m\]'
export DEFAULT='\[\033[0m\]'

#-----------------------------------------------------------------------------
# VI(M)
#-----------------------------------------------------------------------------
export EDITOR='vi'

#-----------------------------------------------------------------------------
# MACHINE SPECIFIC SETTINGS
#-----------------------------------------------------------------------------
case $(hostname) in
    "jd"|"fabian")
        # alias
        alias WG="cd ~/Dropbox/Project_ITP/Project_EP/Project_Mailybaev/_VSC"
        alias OM="cd ~/Dropbox/Project_ITP/Project_EP/Project_Rabl/_paper/"

        # todo.txt aliases and paths
        alias t='todo.sh'
        alias tp='t view project_view_without_groceries'
        alias tc='t view context'
        alias tpg='t view project'
        alias tpd='t view project_done'
        alias tpdd='t view project_done all'
        alias tdp='t view project_date'

        if [ -f $HOME/Dropbox/Scripts/todo.txt_cli-2.9/todo_completion ]; then
            source $HOME/Dropbox/Scripts/todo.txt_cli-2.9/todo_completion
            PATH=$PATH:$HOME/Dropbox/Scripts/todo.txt_cli-2.9
        fi

        # path
        # brew binaries before system defaults
        PATH=/usr/local/bin:$PATH

        PYTHONPATH=$PYTHONPATH:$CODE_PATH/PythonGreensCode

        # promt
        export PS1="${GREEN}\u${WHITE}:${LIGHTCYAN}\w${WHITE}\$(__git_ps1) ${GREEN}\$ ${DEFAULT}"

        case $(hostname) in
            "jd")
                # alias
                alias ipn='ipython notebook --pylab=inline --browser=Safari'

                # iTerm2 colors
                export TERM=xterm-256color
            ;;
            "fabian")
                # alias
                alias gnuplot='rlwrap -a -c gnuplot'
                alias ipn='ipython notebook --pylab=inline --browser=chromium-browser'
                alias open='gnome-open'
                # use autofs instead
                #alias vscmount='sshfs doppler@vsc.tuwien.ac.at:/home/lv70072/doppler /home/doppler/VSC'
                alias VSC="cd $HOME/VSC/VSC1"

                # MKL environment
                # source ~/intel/mkl/bin/intel64/mklvars_intel64.sh
                export LD_LIBRARY_PATH="/home/doppler/intel/mkl/lib/intel64/"
             ;;
        esac
        ;;
    "l01"|"l21.gb")

        # alias
        alias greens_code='cd ~/bin/greens_code/src'
        alias python="$HOME/bin/python2.7"
        alias gnuplot='/opt/sw/gnuplot/4.6/bin/gnuplot'

        # path
        PATH=~/.local/bin:$PATH

        # MKL environment
        PATH=$PATH:/opt/intel/impi/4.1.1.036/intel64/bin

        # increase stack size
        ulimit -s unlimited

        case $(hostname) in
            "l01")
                # alias
                alias mirage='/home/lv70072/libischg/bin/mirage'

                # pythonpath
                PYTHONPATH=$PYTHONPATH:/opt/sw/numpy/1.8.0/lib64/python2.7/site-packages/
                PYTHONPATH=$PYTHONPATH:/opt/sw/scipy/0.13.2_numpy1.8.0/lib/python2.7/site-packages/

                # prompt
                export PS1="${GREEN}\u${WHITE}@${GREEN}VSC-1:${LIGHTCYAN}\w${WHITE}\$(__git_ps1) ${GREEN}\$ ${DEFAULT}"
            ;;
            "l21.gb")
                # alias
                alias mirage='/home/lv70387/florianL/bin/mirage'

                # prompt
                export PS1="${WHITE}\u${GREEN}@${WHITE}VSC-2:${LIGHTCYAN}\w${WHITE}\$(__git_ps1) ${GREEN}\$ ${DEFAULT}"

                # no core dumps
                ulimit -c 0
            ;;
        esac
    ;;
esac

#-----------------------------------------------------------------------------
# COMMON ALIASES
#-----------------------------------------------------------------------------
if [ "$(uname)" == "Darwin" ]; then
    # main code directory
    CODE_PATH="$HOME/Dropbox/Project_ITP/Code"
    # alias
    alias ls='ls -GF'
    alias vi='/usr/local/bin/vim'
    alias vim='/usr/local/bin/vim'
    alias vless="vim -u /usr/share/vim/vim74/macros/less.vim"
    alias vimdiff='/usr/local/bin/vimdiff'
elif [ "$(uname)" == "Linux" ]; then
    # main code directory
    CODE_PATH="$HOME/bin"
    # tell python to skip buffering
    export PYTHONUNBUFFERED=1
    # greens_code xml templates
    export GREENS_CODE_XML=$HOME/bin/xml_templates
    # alias
    alias ls='ls -GF --color=auto'
    alias vi="$HOME/.local/bin/vim"
    alias vim="$HOME/.local/bin/vim"
    alias vless="vim -u $HOME/.local/share/vim/vim74/macros/less.vim"
    alias vimdiff="$HOME/.local/bin/vimdiff"
fi

alias ip="ipython --pylab" # slow startup due to %matplotlib under MacOSX
alias gru="git remote update && git status"

alias ITP="cd ${CODE_PATH}"
alias EP_code="cd ${CODE_PATH}/exceptional_points"
alias dot='cd $HOME/.dotfiles'

alias vsc='ssh -X doppler@vsc.tuwien.ac.at'
alias pra3='ssh -X pra3@vsc.tuwien.ac.at'
alias vsc2='ssh -X doppler@vsc2.tuwien.ac.at'
alias fabian='ssh -X doppler@fabian.itp.tuwien.ac.at'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#-----------------------------------------------------------------------------
# PATH
#-----------------------------------------------------------------------------
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/bin/greens_code/bin
PATH=$PATH:${CODE_PATH}/shell_utilities
PATH=$PATH:${CODE_PATH}/greens_code_utilities
PATH=$PATH:${CODE_PATH}/exceptional_points/bin
PATH=$PATH:${CODE_PATH}/exceptional_points/ep
export PATH

#-----------------------------------------------------------------------------
# PYTHONPATH
#-----------------------------------------------------------------------------
PYTHONPATH=$PYTHONPATH:${CODE_PATH}/shell_utilities
PYTHONPATH=$PYTHONPATH:${CODE_PATH}/greens_code_utilities
PYTHONPATH=$PYTHONPATH:${CODE_PATH}/exceptional_points
export PYTHONPATH

#-----------------------------------------------------------------------------
# FUNCTIONS
#-----------------------------------------------------------------------------
# shadow solve_xml_mumps found in PATH and print svn revision output to file
# before execution
function solve_xml_mumps {
    if [[ "$1" == "dev" ]]; then
        DEV="_dev"
        ARGS="${@: 2}"
    else
        DEV=""
        ARGS="${@}"
    fi
    SVN_LOG_FILE="SVN_REV.log"
    GREENS_CODE_EXE_PATH=$(which solve_xml_mumps${DEV})
    SVN_DIR=$(dirname $(readlink -f ${GREENS_CODE_EXE_PATH}))/../src
    svn info ${SVN_DIR} > ${SVN_LOG_FILE}
    command solve_xml_mumps${DEV} "$ARGS"
}

#-----------------------------------------------------------------------------
# TMUX
#-----------------------------------------------------------------------------
# taken from http://blog.thelinuxkid.com/2013/06/automatically-start-tmux-on-ssh.html
function use_tmux {
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
}


# open local directory $HOME/VSC/VSC1/path via ssh on VSC1
function VSCopen {
    VSCDIR="$(echo $PWD | sed "s@$HOME/VSC/VSC1@/home/lv70072/doppler@g")"
    ssh -X doppler@vsc.tuwien.ac.at -t "cd $VSCDIR && /bin/bash --login"
}
