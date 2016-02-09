.dotfiles
===

###Installation
```sh
git clone --recursive git@github.com:jdoppler/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x createsymlinks.sh && ./createsymlinks.sh
```

###Contents
* ###bashrc

* ###gitconfig

* ###inputrc

* ###matplotlibrc

* ###ssh_config

* ###tmux & tmux.conf

* ###vim & vimrc
 A tweaked .vimrc file with some plugins to make life easier:
 * [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)
 * [jedi-vim](https://github.com/davidhalter/jedi-vim)
 * [LaTeX-Box](https://github.com/LaTeX-Box-Team/LaTeX-Box)
 * [nerdtree](https://github.com/scrooloose/nerdtree)
 * [supertab](https://github.com/ervandew/supertab)
 * [tcomment](https://github.com/tomtom/tcomment_vim)
 * [tmuxline.vim](https://github.com/edkolev/tmuxline.vim)
 * [UltiSnips](https://github.com/SirVer/ultisnips)
 * [vim-airline](https://github.com/bling/vim-airline)
 * [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
 * [vim-flake8](https://github.com/nvie/vim-flake8)
 * [vim-fugitive](https://github.com/tpope/vim-fugitive)
 * [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
 * [vim-ipython](https://github.com/ivanov/vim-ipython)
 * [vim-snippets](https://github.com/honza/vim-snippets)

 ####Adding plugins
 ```sh
 cd ~/.dotfiles
 git submodule add [git-repository-url] vim/bundle/[plugin-name]
 git submodule update --init
 ```

 ####Upgrading plugins
 ```sh
 cd ~/.dotfiles
 git submodule foreach git pull origin master
 ```
