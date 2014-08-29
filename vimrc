" ============================================================================
"
"   .vimrc 
"   taken largely from https://github.com/mbrochh/vim-as-a-python-ide
"
" ============================================================================


" ensure that custom eof/tab listchars work
set encoding=utf-8


" automatic reloading of .vimrc
autocmd! BufWritePost .vimrc source %


" check if file changed on disk and reload
set autoread
au CursorMoved,CursorMovedI * :silent! !
au CursorHold,CursorHoldI * :silent! !
au FocusGained,WinEnter,BufEnter,BufWinEnter * :silent! !


" command-line completion
set wildmenu
set wildmode=list:longest,full


" better copy & paste
set pastetoggle=<F12>
set clipboard=unnamed,unnamedplus


" mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again


" rebind <Leader> key
let mapleader = ","


" remove highlight from the last search
noremap <silent> <Leader>c :nohl<CR>


" Quicksave command
"" noremap <C-Z> :update<CR>
"" vnoremap <C-Z> <C-C>:update<CR>
"" inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
"" noremap <Leader>e :quit<CR>  " Quit current window
"" noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h


" do not move linewise
nnoremap j gj
nnoremap k gk

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" show whitespace
" MUST be inserted BEFORE the colorscheme command
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme 
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" git clone https://github.com/tomasr/molokai.git
set t_Co=256
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
set background=light


" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
"set number  " show line numbers
"set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight MatchParen cterm=bold ctermbg=none ctermfg=red
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=233


" easier formatting of paragraphs
"" vmap Q gq
"" nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smartindent


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile


set hidden
set nocompatible
set modelines=0


set laststatus=2
set ruler
set cursorline


imap jj <ESC>


" show whitespace
set list
set listchars=tab:▸\ ,eol:¬


" toggle relative linenumber " default: hybrid mode
set relativenumber
set number
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set number
    set relativenumber
  endif
endfunc
nnoremap <F3> :call NumberToggle()<CR>


" reformat .xml files
command FormatXML :%!xmllint --format --recover \- <CR>

" show diff between current buffer and the original file
command Diff :w !diff % -


" show registers
" taken from http://superuser.com/questions/656949/always-show-the-register-list-in-vim
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>


" execute current file
nnoremap <F2> :!%<CR>


" vimdiff settings
" taken from http://superuser.com/questions/198779/make-vimdiff-show-entire-file
" if &diff
"     set diffopt=filler,context:1000000
" endif
"

" ============================================================================
"
"   Plugins
"
"   to update:
"       git submodule update --init --recursive
"
" ============================================================================


" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()


" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
let g:jedi#usages_command = "<leader>u"
let g:jedi#rename_command = "<leader>r"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = 1
let g:jedi#completions_command = "<C-Space>"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"

" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>


" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Settings for Flake8
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>

" Settings for tComment
"
" Settings for Supertab
"
" Settings for NERDTree
nmap <F4> :NERDTreeToggle<CR>
