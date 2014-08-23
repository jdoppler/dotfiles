#!/bin/bash
###############################################################################
#   
#   createsymlinks.sh
#   create symlinks from $HOME to all files/folders in ~/.dotfiles
#   adapted from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
#

DOTDIR=$HOME/.dotfiles
FILES="bashrc inputrc vim vimrc"

for file in $FILES; do
    echo "Creating symlink to $file in \$HOME..."
    ln -s $DOTDIR/$file $HOME/.$file
    echo "...done"
done
