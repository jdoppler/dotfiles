#!/bin/bash
###############################################################################
#   
#   createsymlinks.sh
#    create symlinks from $HOME to all files/folders in ~/.dotfiles
#    adapted from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
#    and https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
#

DOTDIR=$HOME/.dotfiles
FILES="bashrc inputrc vim vimrc ssh/config"

for file in $FILES; do
    DOTFILE=$HOME/.$file

    echo "Creating symlink to $file in \$HOME..."

    if [[ -L "$DOTFILE" ]]; then
        echo "Warning: $DOTFILE symlink to $(readlink $DOTFILE) already exists"
        read -p "Overwrite? (y/n) " -n 1

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            ln -sf $DOTDIR/$file $DOTFILE
        fi;
    else
        ln -s $DOTDIR/$file $DOTFILE
    fi
    echo "...done"
done
