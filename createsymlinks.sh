#!/bin/bash
###############################################################################
#
#   createsymlinks.sh
#    create symlinks from $HOME to all files/folders in ~/.dotfiles
#    adapted from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
#    and https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh
#    and http://blog.endpoint.com/2009/09/using-ln-sf-to-replace-symlink-to.html
#     (to fix a bug when replacing a symlinked folder)
#

DOTDIR=$HOME/.dotfiles
FILES="bashrc
       gitconfig
       inputrc
       ssh/config
       vim
       vimrc"

for file in $FILES; do
    DOTFILE=$HOME/.$file

    echo "Creating symlink to $file in \$HOME..."

    if [[ -e "$DOTFILE" ]]; then
        if [[ -L "$DOTFILE" ]]; then
            echo "Warning: $DOTFILE symlink to $(readlink $DOTFILE) already exists"
        else
            echo "Warning: $DOTFILE already exists"
        fi
        read -p "Overwrite? (y/n) " -n 1

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            ln -sfn $DOTDIR/$file $DOTFILE
        fi
    else
        ln -s $DOTDIR/$file $DOTFILE
    fi
    echo "...done"
done
