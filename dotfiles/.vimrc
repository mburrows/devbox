" Use Vundle for plugin management
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Vundle/Vundle.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-dispatch'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'vim-scripts/VisIncr'
Plugin 'chriskempson/base16-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'wincent/terminus'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
call vundle#end()

set nowrap               " turn off line wrapping, turn it back on with :Wrap
set backspace=indent,eol,start
set nobackup             " don't create backup files (everything I edit is in version control)
set noswapfile
set nowb
set ruler                " show line and column number
set showcmd              " show partial commands
set hidden               " allow modified buffers to be hidden
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " no honestly, don't beep
set wildmenu             " make tab completion for files/buffers act like bash
set wildmode=longest,list,full
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set spelllang=en_gb
set dictionary=~/.ispell_british,/usr/share/dict/words
set virtualedit=all      " allow movement through virtual whitespace
set autowrite            " auto write file contents when switching buffers
set showmode
set nocursorline
set viewdir=$HOME/.vim/views
set lazyredraw           " dont redraw whilst executing macros
set mousehide
set confirm
set relativenumber
set number

" Change the mapleader to space key
let mapleader="\<Space>"

" Turn on doxygen syntax highlighting (for C++ comments)
let g:load_doxygen_syntax=1

" Add dictionary to completion set (but only if spelling is turned on)
set complete=.,w,b,u,t,i,kspell
                                              
" Make searching sane
set ignorecase
set smartcase
set gdefault " turn on global searching by default
set incsearch
set showmatch
set nohlsearch

" Tabs are evil, always use spaces
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'

" Setup search path for gf and :find
set path+=~/cpp/**

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co >= 8 || has("gui_running")
    syntax on
    set t_Co=256
    set background=dark                                  
    let base16colorspace=256  " Access colors present in 256 colorspace
    colorscheme base16-tomorrow-night
    " tabs, grey out inactive menus, menu bar, console dialogs, no scrollbars,
    " no toolbars
    set guioptions=egmc
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection, plugins and indentation
    filetype on
    filetype plugin on
    filetype indent on

    " Put these in an autocmd group, so that we can delete them easily and
    " they don't get sourced twice when we reload our .vimrc
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 80 characters.
        autocmd FileType text setlocal textwidth=80

        " When editing a file, always jump to the last known cursor position.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

        " Autoload .vimrc when I save it
        autocmd BufWritePost .vimrc source $MYVIMRC

        " Avoid polluting buffer list with fugitive buffers
        autocmd BufReadPost fugitive://* set bufhidden=delete

        " Use WAF for ECN builds                              
        autocmd BufRead,BufNewFile **/ecn/**/*.cpp setlocal makeprg=~/cpp/waf\ -j48\ -pp\ 2\>\&1\|\ egrep\ -v\ '^ICECC\|\ note:' tags+=~/cpp/tags
        autocmd BufRead,BufNewFile **/ecn/**/*.h setlocal makeprg=~/cpp/waf\ -j48\ -pp\ 2\>\&1\|\ egrep\ -v\ '^ICECC\|\ note:' tags+=~/cpp/tags
        autocmd BufRead,BufNewFile **/ecn/**/*.py setlocal tags+=~/python/tags
        
        " Prefer // for C++ comments
        autocmd FileType cpp setlocal commentstring=//\ %s

        " Treat .sqli files as SQL
        autocmd BufNewFile,BufRead *.sqli setfiletype sql
                            
        " Treat .md files as Markdown rather than Modula-2
        autocmd BufNewFile,BufReadPost *.md setfiletype markdown

        " Treat .cir files as SPICE circuits
        autocmd BufNewFile,BufRead *.cir setfiletype spice

        if has('statusline')
            set laststatus=2                         " always display the status line
            set statusline=%<%f\                     " filename
            set statusline+=%w%h%m%r                 " options
            set statusline+=%{fugitive#statusline()} " git hotness
            set statusline+=\ [%{&ff}/%Y]            " filetype
            set statusline+=\ [%{getcwd()}]          " current dir
            "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / hexadecimal value of char
            set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " right aligned file nav info
        endif

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" Remap esc key for fast switching and ipad keyboards
inoremap jj <Esc>
cnoremap jj <Esc>

" Make opening of files in the same directory easier, and use %% in command
" mode to expand the directory of the current file.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Turn on all the options to wrap text properly
command! -nargs=* Wrap set wrap linebreak nolist

" Select just pasted text
nnoremap gp `[v`]

" Automatically jump to end of text you paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Filter previous/next ex commands with C-p and C-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Only show H1 headers. The other option is 'stacked' which shows all headers.
let g:markdown_fold_style = 'nested'

" Stop the nonsense
noremap q: :q
cabbrev ew :wq
cabbrev qw :wq 

" Hit v to select one character, v again to expand selection, C-v to shrink it
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Always use very magic mode when searching
nnoremap / /\v
nnoremap ? ?\v

" Really short shortcuts
nnoremap <leader><leader> :
nnoremap <leader>8 :execute ":Ggrep " . expand("<cword>")<CR>
nnoremap <leader>5 :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <leader><tab> <C-^>

" b - buffers
"     bd - buffer delete
"     bc - buffer close
"     bb - CtrlPBuffer
"     bl - buffer list
"     bp - buffer previous
"     bn - buffer next
"     br - buffer rewind
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bc :bdelete<CR>
nnoremap <leader>bb :CtrlPBuffer<CR>
nnoremap <leader>bl :ls<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>br :brewind<CR>

" c - clipboard
"   cd - clipboard delete
"   cy - clipboard yank
"   cp - clipboard paste
nnoremap <leader>cd "*d
vnoremap <leader>cd "*d
nnoremap <leader>cy "*y
vnoremap <leader>cy "*y
nnoremap <leader>cp "*p
vnoremap <leader>cp "*p
nnoremap <leader>cr :registers<CR>

" d - delete
"     df - delete function
"     dw - delete trailing whitespace
"     dl - delete empty lines
"     do - only one space
nnoremap <leader>dw :%s/\s\+$//e<CR>
" TODO: implement df - delete function
" TODO: implement dl - delete empty lines
" TODO: implement do - only one space

" e - edit
"     ee - edit %%
"     ev - edit vertically
"     eh - edit split (horizontally)
"     es - edit split (horizontally)
"     et - edit tab
noremap <expr> <leader>ee ':edit ' . expand('%:h') .'/'
noremap <expr> <leader>es ':split ' . expand('%:h') .'/'
noremap <expr> <leader>eh ':split ' . expand('%:h') .'/'
noremap <expr> <leader>ev ':vert split ' . expand('%:h') .'/'
noremap <expr> <leader>et ':tabedit ' . expand('%:h') .'/'

" f - files
"     fs - file save
"     fS - save all files
"     fv - .vimrc
"     fr - CtrlPMRU
"     ff - file open %%
"     fj - file jump (NerdTree locate file)
"     fl - open last file
"     fW - write out as sudo
"     fh - header/implementation file
"     fi - find inline header file
"     ft - NerdTree toggle
nnoremap <leader>fs :update<CR>
nnoremap <leader>fS :wall<CR>
nnoremap <leader>fW :w !sudo tee % >/dev/null<CR>
nnoremap <leader>fv :tabedit ~/.vimrc<CR>
nnoremap <leader>fr :CtrlPMRUFiles<CR>
nnoremap <leader>ff :CtrlP<CR>
nnoremap <leader>ft :NERDTreeToggle<CR>
nnoremap <leader>fj :NERDTreeFind<CR>
nnoremap <leader>fl :execute "rightbelow vsplit " . bufname('#')<CR>
nnoremap <leader>fh :edit %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" TODO: implelement fi - find inline header file

" g - git
"     gg - git grep
"     gs - git status
"     gc - git commit
"     gb - git blame
"     gd - git diff
"     go - git diff origin
"     gv - git svnup
"     gz - git stash
"     gp - git stash pop
"     gl - git log
"     gr - git rebase master
nnoremap <leader>gg :Glgrep 
nnoremap <leader>gg :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>go :Gdiff origin<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gv :Git svnup<CR>
nnoremap <leader>gz :Git stash<CR>
nnoremap <leader>gp :Git stash pop<CR>
nnoremap <leader>gl :Gllog<CR>
nnoremap <leader>g1 :Git log --oneline<CR>
nnoremap <leader>gr :Git rebase master

" h - help
"     hh - help
"     hf - help functions
"     hs - help vim scripts
nnoremap <leader>hh :tab help 
nnoremap <leader>hf :tab help functions<CR>
nnoremap <leader>hs :tab help usr_41.txt<CR>
nnoremap <expr> <leader>hw ':tab help ' . expand("<cword>")

" l - locations
"     ll - open location list
"     ln - next location
"     lp - previous location
"     lf - next location file
"     lb - previous location file
"     lc - close location list
"     lr - rewind location list
nnoremap <leader>ll :lwindow 15<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprev<CR>
nnoremap <leader>lf :lnfile<CR>
nnoremap <leader>lb :lpfile<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>lr :lrewind<CR>

" p - project
"     pt - project tree
"     pf - open file at project root (CtrlP ~/cpp)
"     pc - project compile
nnoremap <leader>pf :CtrlP ~/cpp<CR>
nnoremap <leader>pt :NERDTree ~/cpp<CR>
nnoremap <leader>pc :Make<CR>

" q - quicklist
"     qq - open quicklist
"     qn - next item
"     qp - previous item
"     qf - next file
"     qb - previous file
"     qc - close quicklist
"     qr - rewind quicklist
nnoremap <leader>qq :cwindow 15<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qf :cnfile<CR>
nnoremap <leader>qb :cpfile<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qr :crewind<CR>

" r - run tests
"     rt - run test (dispatch)
"     rd - run test (dispatch!)
"     rc - focus on test case and run it
"     rs - focus on test suite and run it
"     rp - run parallel test
nnoremap <leader>rt :Dispatch<CR>
nnoremap <leader>rd :Dispatch!<CR>
" TODO: implement rc
" TODO: implement rs
" TODO: implement rp

" s - search
"     sg - grep
"     sG - grep add
"     sf - find
"     st - CtrlPTag
"     sw - search current word
"     sr - search and replace current word
nnoremap <leader>sg :lvimgrep 
nnoremap <leader>sG :lvimgrepadd 
nnoremap <leader>sf :find 
nnoremap <leader>st :CtrlPTag<CR>
nnoremap <expr> <leader>sw ':lvimgrep ' . expand("<cword>")
nnoremap <leader>sr :%s/\<<C-r>=expand("<cword>")<CR>\>/

" t - toggle
"     th - toggle highlight
"     tw - toggle whitespace
"     tn - toggle line numbers
nnoremap <leader>th :set hlsearch!<CR>
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
nnoremap <leader>tw :set list!<CR>
nnoremap <leader>tn :set relativenumber!<CR>:set number!<CR>

" w - window
nnoremap <leader>w <C-w>

" x - modification
"     x= - align on -
"     x: - align on :
"     x, - align on ,
noremap <leader>x= :Tabularize /=<CR>
noremap <leader>x: :Tabularize /:\zs<CR>
noremap <leader>x, :Tabularize /,\zs/l0r1<CR>
