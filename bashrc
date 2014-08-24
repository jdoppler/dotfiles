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

#-----------------------------------------------------------------------------
# HISTORY
#-----------------------------------------------------------------------------
shopt -s histappend
export HISTSIZE=100000
export PROMPT_COMMAND="history -a; history -n;"

#-----------------------------------------------------------------------------
# GIT
#-----------------------------------------------------------------------------
alias gru='git remote update && git status'

# git auto-completion
source ~/.git-completion.bash

# git shell promt
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
    "jd.local"|p238-???.vps.tuwien.ac.at|"fabian")
        # main code directory
        CODE_PATH="$HOME/Dropbox/Project_ITP/Code/"

        # alias
        alias WG="cd ~/Dropbox/Project_ITP/Project_EP/Project_Mailybaev/_full_waveguide_calculation/_vsc_setup"
        alias OM="cd ~/Dropbox/Project_ITP/Project_EP/Project_Rabl/_paper/"

        # todo.txt
        alias t='todo.sh'
        alias tp='t view project_view_without_groceries' # show projects without groceries list 
        alias tc='t view context'
        alias tpg='t view project'
        alias tpd='t view project_done'
        alias tpdd='t view project_done all'
        alias tdp='t view project_date'

        source $HOME/Dropbox/Scripts/todo.txt_cli-2.9/todo_completion
        source $HOME/Dropbox/Scripts/todo.txt_cli-2.9/todo_alias

        PATH=$PATH:$HOME/Dropbox/Scripts/todo.txt_cli-2.9

        # path
        PATH=$PATH:/usr/local/bin

        # promt
        export PS1="${GREEN}\u${WHITE}:${LIGHTCYAN}\w${WHITE}\$(__git_ps1) ${GREEN}\$ ${DEFAULT}"

        case $(hostname) in
            "jd.local"|"p238-???.vps.tuwien.ac.at")
                # alias
                alias ipn='ipython notebook --pylab=inline --browser=Safari'

                # iTerm2 colors
                export TERM=xterm-256color
            ;;
            "fabian")
                # alias
                alias open='gnome-open'
                alias ipn='ipython notebook --pylab=inline --browser=chromium-browser'

                # path
                PATH=$PATH:$HOME/bin
                PATH=$PATH:$HOME/bin/Komodo-Edit-8/bin
             ;;
        esac
        ;;
    "l01"|"l21.gb")
        # main code directory
        CODE_PATH="$HOME/bin/"

        # alias
        alias greens_code='cd ~/bin/greens_code/src'
        alias python="$HOME/bin/python2.7"
        alias gnuplot='/opt/sw/gnuplot/4.6/bin/gnuplot'

        # path
        PATH=~/.local/bin:$PATH
        PATH=$PATH:$HOME/bin

        #export VIMRUNTIME=$HOME/.local/share/vim/vim74/
        #export LC_ALL=C
        #export OMP_NUM_THREADS=1

        case $(hostname) in
            "l01")
                # alias
                alias mirage='/home/lv70072/libischg/bin/mirage'

                # path
                PATH=$PATH:/opt/sw/gnuplot/4.6/bin

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
            ;;
        esac
    ;;
esac

#-----------------------------------------------------------------------------
# COMMON ALIASES
#-----------------------------------------------------------------------------
if [ "$(uname)" == "Darwin" ]; then
    alias ls='ls -GF'
    alias vi='/usr/local/bin/vim'
    alias vim='/usr/local/bin/vim'
    alias vless="vim -u /usr/share/vim/vim74/macros/less.vim"
    alias vimdiff='/usr/local/bin/vimdiff'
elif [ "$(uname)" == "Linux" ]; then
    alias ls='ls -GF --color=auto'
    alias vi="$HOME/.local/bin/vim"
    alias vim="$HOME/.local/bin/vim"
    alias vless="vim -u $HOME/.local/share/vim/vim74/less.vim"
    alias vimdiff="$HOME/.local/bin/vimdiff"
fi

alias ip="ipython --pylab"
alias gru="git remote update && git status"

alias ITP="cd ${CODE_PATH}"
alias EP_code="cd ${CODE_PATH}/exceptional-points"

alias vsc='ssh -X doppler@vsc.tuwien.ac.at'
alias vsc2='ssh -X doppler@vsc2.tuwien.ac.at'
alias fabian='ssh -X doppler@fabian.itp.tuwien.ac.at'

#-----------------------------------------------------------------------------
# PATH
#-----------------------------------------------------------------------------
PATH=$PATH:$HOME/${CODE_PATH}/shell_utilities
PATH=$PATH:$HOME/${CODE_PATH}/greens_code_utilities
PATH=$PATH:$HOME/${CODE_PATH}/exceptional-points/bin
PATH=$PATH:$HOME/${CODE_PATH}/exceptional-points/ep
export PATH

#-----------------------------------------------------------------------------
# PYTHONPATH
#-----------------------------------------------------------------------------
PYTHONPATH=$PYTHONPATH:$HOME/${CODE_PATH}/shell_utilities
PYTHONPATH=$PYTHONPATH:$HOME/${CODE_PATH}/greens_code_utilities
PYTHONPATH=$PYTHONPATH:$HOME/${CODE_PATH}/exceptional-points/bin
PYTHONPATH=$PYTHONPATH:$HOME/${CODE_PATH}/exceptional-points/ep
export PYTHONPATH
