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

* ###inputrc

* ###vim & vimrc
 A tweaked .vimrc file with some plugins to make life easier:
 * [jedi-vim](https://github.com/davidhalter/jedi-vim)
 * [nerdtree](https://github.com/scrooloose/nerdtree)
 * [supertab](https://github.com/ervandew/supertab)
 * [tcomment](https://github.com/tomtom/tcomment_vim)
 * [vim-flake8](https://github.com/nvie/vim-flake8)
 * [vim-fugitive](https://github.com/tpope/vim-fugitive)
 
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
