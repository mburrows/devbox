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
Plugin 'tpope/vim-fugitive'
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

" Use Q for formatting the current paragraph (or selection)
vnoremap Q gq
nnoremap Q gqap

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

" Quick dispatches
noremap <F1> :Make<CR>
noremap <F2> :Dispatch<CR>
noremap <F3> :Dispatch!<CR>
noremap <F4> :cwin<CR>

" Fast switching between .h and .cpp files
noremap <leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Use to turn off autoindenting when pasting from the clipboard
set pastetoggle=<F5>

" Rapidly switch between quicklist entries
noremap <F9>  :cprev<CR>
noremap <F10> :cnext<CR>
noremap <F11> :cpf<CR>
noremap <F12> :cnf<CR>

" Easy closing of quicklist/preview windows
nnoremap <leader>c :cclose<CR>:pclose<CR>

" Shortcut to search for current word under cursor using git grep
nnoremap <leader>8 :exe ":Ggrep " . expand("<cword>")<CR>

" Quickly edit the vimrc file
nnoremap <leader>v :tabedit $MYVIMRC<CR>

" Write out as sudo with w!!
cmap w!! w !sudo tee % >/dev/null

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nnoremap <leader>5 :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Cleanup trailing whitespace with ,w
nnoremap <leader>w :%s/\s\+$//e<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>t :set list!<CR>
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Make opening of files in the same directory easier, and use %% in command
" mode to expand the directory of the current file.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" cd to the directory containing the file in the buffer
noremap <leader>cd :lcd %:h

" Turn on all the options to wrap text properly
command! -nargs=* Wrap set wrap linebreak nolist

" Shortcuts for tabular alignment
noremap <leader>z= :Tabularize /=<CR>
noremap <leader>z: :Tabularize /:\zs<CR>
noremap <leader>z, :Tabularize /,\zs/l0r1<CR>

" Fast delete a buffer
noremap <leader>x :bd<CR>

" Fast save
noremap <leader>s :update<CR>

" Browse old files
noremap <leader>o :browse oldfiles<CR>

" Select just pasted text
nnoremap gp `[v`]

" Git shortcuts
nnoremap <leader>gg :Ggrep 
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>go :Git diff origin

" Toggle relative line numbers (useful for terminal copying)
nnoremap <leader>n :ToggleMouse<CR>

" Automatically jump to end of text you paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Quicker clipboard copy and paste
nnoremap <leader>p "*p
nnoremap <leader>y "*y
nnoremap <leader>d "*d
vnoremap <leader>p "*p
vnoremap <leader>y "*y
vnoremap <leader>d "*d

" Fast opening of files in current directory
map <leader>e  :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Filter previous/next ex commands with C-p and C-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Only show H1 headers. The other option is 'stacked' which shows all headers.
let g:markdown_fold_style = 'nested'

" Use Ctrl-P for file navigation
map <leader>j :CtrlPMixed<CR>
map <leader>m :CtrlPMRUFiles<CR>

" Quick quicklist
map <leader>q :cwin<CR>

" Stop the nonsense
noremap q: :q
cabbrev ew :wq
cabbrev qw :wq 
nnoremap ; :
nnoremap : ;

" Open last file in vertical split
noremap <leader>l :execute "rightbelow vsplit " . bufname('#')<CR>

" Hit v to select one character, v again to expand selection, C-v to shrink it
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Always use very magic mode when searching
nnoremap / /\v
nnoremap ? ?\v
