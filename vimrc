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
set mouse=a  " to still copy a selection, press shift (Linux) or alt (Mac)
             " while selecting
set bs=2     " make backspace behave like normal again


" rebind <Leader> key
let mapleader = ","
let maplocalleader = ","


" remove highlight from the last search
noremap <silent> <Leader>c :nohl<CR>


" quicksave command
"" noremap <C-Z> :update<CR>
"" vnoremap <C-Z> <C-C>:update<CR>
"" inoremap <C-Z> <C-O>:update<CR>


" quick quit command
"" noremap <Leader>e :quit<CR>  " Quit current window
"" noremap <Leader>E :qa!<CR>   " Quit all windows


" open vsplits on the right
set splitright


" bind Ctrl+<movement> keys to move around the windows, instead of using 
" Ctrl+w + <movement>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h


" do not move linewise
nnoremap j gj
nnoremap k gk


" always show some screenlines below the cursor
set scrolloff=5

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" show whitespace (must be inserted before the colorscheme command)
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" git clone https://github.com/tomasr/molokai.git
set t_Co=256
colorscheme molokai
" let g:molokai_original=1
" let g:rehash256=1
" set background=light


" enable syntax highlighting
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


" increase history size
set history=700
set undolevels=700


" jump to last position if reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" use tabs instead of spaces
set tabstop=4
set softtabstop=4
set expandtab

set shiftwidth=4
set shiftround
set smartindent
" repair smartindent default which places comment characters at the beginning of
" a line: http://stackoverflow.com/questions/2360249
inoremap # X#

" use tabs for makefiles and *.inc files
autocmd FileType make,pov setlocal noexpandtab shiftwidth=8 softtabstop=0


" make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" disable backup and swap files
set nobackup
set nowritebackup
set noswapfile


set hidden
set nocompatible
set modelines=0

set ruler
set cursorline

set lazyredraw
set showmatch

" statusline
set laststatus=2
" the following lines are ignored with vim-airline switched on
set statusline=
set statusline+=%-10.3n\                     " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=%{fugitive#statusline()}\    " git status
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file typ
set statusline+=%=                           " right align remainder
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position


" press jj to enter command mode
imap jj <ESC>

" show whitespace
set list
set listchars=tab:▸\ ,eol:¬


" toggle relative linenumber
" default: hybrid mode (only in vim 7.4)
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
command Diff :w !diff %


" toggle :window diffthis
" taken from http://www.bestofvim.com/tip/diff-diff/
nnoremap <silent> <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
    if &diff
        diffoff
    else
        windo diffthis
    endif
:endfunction


" show registers
" taken from http://superuser.com/questions/656949/always-show-the-register-list-in-vim
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>


" show marks
" note that m cannot be associated with a mark anymore
nnoremap <silent> mm :marks <CR>


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


" setup pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()


" settings for fugitive-vim
command Gru :Gfetch <Bar> :Gstatus


" settings for jedi-vim
let g:jedi#usages_command = "<leader>u"
let g:jedi#rename_command = "<leader>r"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = 1
let g:jedi#completions_command = "<C-space>"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"


" better navigating through omnicomplete option list
" see http://stackoverflow.com/questions/2170023/
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


" Settings for LaTeX-Box
let g:LatexBox_quickfix=3
let g:LatexBox_latexmk_options = "-pdflatex='pdflatex -synctex=1 \%O \%S'"
if has('macunix')
    let g:LatexBox_viewer = "open"
    map <silent> <LocalLeader>ls :silent !/Users/jdoppler/Downloads/Skim.app/Contents/SharedSupport/displayline -b
                \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>" "%:p"<CR>
elseif has('unix')
    " let g:LatexBox_viewer = "evince"
    " let g:LatexBox_viewer = "okular --unique"
    let g:LatexBox_viewer = "zathura"

    ""
    "" taken and adapted from https://github.com/gergap/vim-latexview
    ""

    "" The function FindRoot() is from the script
    "" live-latex-preview.vim by Kevin C. Klement
    "" klement <at> philos <dot> umass <dot> edu

    "" Search for root file
    function! FindRoot()
        let g:RootFile = expand("%")
        for linenum in range(1,5)
            let linecontents = getline(linenum)
            if linecontents =~ 'root\s*='
                let g:RootFile = expand("%:p:h")."/".substitute(linecontents, '.*root\s*=\s*', "", "")
                let g:RootFile = substitute(g:RootFile, '\s*$', "", "")
                echom "RootFile=".g:RootFile
            endif
        endfor
        let g:RootFileName = substitute(g:RootFile, '\.tex$', "", "")
    endfunction
    call FindRoot()

    " Forward search
    " function! PDFForward()
    "     call FindRoot()
    "     if filereadable(g:RootFileName."."."pdf")
    "         let cmd = g:LatexBox_viewer . " \"".g:RootFileName."."."pdf"."\"\#src:".line('.').expand("%:p")." &" "
    "         " let cmd1 = g:LatexBox_viewer . " --synctex-forward -x 'vim +%{line} %{input}' ".g:RootFileName."."."pdf"." &"
    "         " let cmd2 = g:LatexBox_viewer . " --synctex-forward ".line('.').":1:".expand("%:p")." ".g:RootFileName."."."pdf"
    "         " echom "cmd1=".cmd1
    "         " echom "cmd2=".cmd2
    "         " silent! call system(cmd1)
    "         " silent! call system(cmd2)
    "         silent! call system(cmd)
    "     else
    "         echo "Output file not readable."
    "     endif
    " endfunction
    "
    function! Zathura_SyncTexForward()
        call FindRoot()
        let source = expand("%:p")
        let input = shellescape(line(".").":".col(".").":".source)
        " let output = g:RootFileName."."."pdf"
        let output = LatexBox_GetOutputFile()
        let execstr = "zathura --synctex-forward=".input." ".shellescape(output)
        silent! call system(execstr)
    endfunction
    " nmap <buffer> <Leader>f :call Zathura_SyncTexForward()<CR>
    nmap <Leader>ls :call Zathura_SyncTexForward()<CR>

    " Mapping forward search to <leader>ls
    " nmap <Leader>ls :call PDFForward()<CR>
endif


" Settings for NERDTree
nmap <F4> :NERDTreeToggle<CR>


" Settings for tComment


" Settings for Supertab
let g:SuperTabDefaultCompletionType = "context"


" Settings for UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"


" Settings for vim-airline
let g:airline_theme="badwolf"
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled=0
let g:airline_section_y=airline#section#create(['BN: %n'])  " show buffernumber
let g:airline_section_warning=''
" tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '#W %R',
      \'z'    : '#H'}


" Settings for vim-flake8
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>


" Settings for vim-gitgutter
highlight clear SignColumn
let g:gitgutter_sign_column_always=1
set updatetime=750


" Settings for vim-ipython




