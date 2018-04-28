" vim: set foldlevel=1 foldmethod=marker:
set nocompatible

" Plugins {{{1
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'craigemery/vim-autotag'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/VisIncr'
Plug 'vim-scripts/argtextobj.vim'
Plug 'wincent/terminus'
Plug 'wincent/loupe'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'mileszs/ack.vim'
call plug#end()
" 1}}}

" Options {{{1
set nowrap               " turn off line wrapping
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
set cursorline
set viewdir=$HOME/.vim/views
set lazyredraw           " dont redraw whilst executing macros
set mousehide
set confirm
set relativenumber
set number
set gdefault             " turn on global searching by default
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set path+=~/cpp/**       " setup search path for gf and :find

if has('mouse')
    set mouse=a
endif

" Tabs are evil, always use spaces
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'

" Switch syntax highlighting on, when the terminal has colors
if &t_Co >= 8 || has("gui_running")
    syntax on
    set t_Co=256
    set background=dark                                  
    let base16colorspace=256  " Access colors present in 256 colorspace
    silent! colorscheme base16-tomorrow-night
    " tabs, grey out inactive menus, menu bar, console dialogs, no scrollbars,
    " no toolbars
    set guioptions=egmc
endif
" 1}}}

" Globals {{{1

" Change the mapleader to space key
let mapleader="\<Space>"

" Make current match more obvious
let g:LoupeHighlightGroup = 'Error'

" Only show H1 headers. The other option is 'stacked' which shows all headers.
let g:markdown_fold_style = 'nested'

" Perty status line
let g:airline_theme = 'base16_tomorrow'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" Increase CtrlP limits for large codebases
let g:ctrlp_max_files = 20000

" Set nerd tree window width
let g:NERDTreeWinSize = 60

" Edit snippets smartly
let g:UltiSnipsEditSplit="context"

" Use the silver searcher if available
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
" 1}}}

" Auto-commands {{{1
if has("autocmd")

    " Enable file type detection, plugins and indentation
    filetype on
    filetype plugin on
    filetype indent on

    " Put these in an autocmd group, so that we can delete them easily and
    " they don't get sourced twice when we reload our .vimrc
    augroup vimrcEx
        autocmd!

        " When editing a file, always jump to the last known cursor position.
        autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

        " Autoload .vimrc when I save it
        autocmd BufWritePost .vimrc source $MYVIMRC

        " Avoid polluting buffer list with fugitive buffers
        autocmd BufReadPost fugitive://* set bufhidden=delete

        " FileType overrides
        autocmd BufNewFile,BufRead *.sqli setfiletype sql
        autocmd BufNewFile,BufRead *.md   setfiletype markdown
        autocmd BufNewFile,BufRead *.cir  setfiletype spice
        autocmd BufNewFile,BufRead *.inc  setfiletype cpp
        autocmd BufNewFile,BufRead */ecn/* compiler gcc
        autocmd BufNewFile,BufRead */ecn/* setlocal makeprg=~/cpp/bb\ debug\ -j32\ -o\ /tmp/build/clang

        " FileType local options
        autocmd FileType text setlocal textwidth=120
        autocmd FileType cpp  setlocal commentstring=//\ %s

        if has('statusline')
            set laststatus=2                         " always display the status line
            set statusline=%<%f\                     " filename
            set statusline+=%w%h%m%r                 " options
            set statusline+=%{fugitive#statusline()} " git hotness
            set statusline+=\ [%{&ff}/%Y]            " filetype
            set statusline+=\ [%{getcwd()}]          " current dir
            set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " right aligned file nav info
        endif

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")
" 1}}}

" Key mappings {{{1

" Remap esc key for fast switching and ipad keyboards
inoremap jk <Esc>
cnoremap jk <Esc>

" Make opening of files in the same directory easier, and use %% in command
" mode to expand the directory of the current file.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

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
vnoremap <leader><leader> :
nnoremap <leader><tab> <C-^>
nnoremap <tab> <C-w><C-w>
nnoremap <leader>/ :LAck 
nnoremap <leader>* :LAck <C-r>=expand("<cword>")<CR> ~/cpp

" a - alternates
"     aa - alternate file
"     av - alternate file in vertical
"     as - alternate file in split
"     at - alternate file in tab
"     ad - replace contents with template
"     ai - alternate .inc file
nnoremap <leader>aa :A<CR>
nnoremap <leader>av :AV<CR>
nnoremap <leader>as :AS<CR>
nnoremap <leader>at :AT<CR>
nnoremap <leader>ad :AD<CR>
nnoremap <expr> <leader>ai ':Einc ' . expand('%:t:r')

" b - buffers
"     bd - buffer delete
"     bc - buffer close
"     bb - CtrlPBuffer
"     bp - buffer previous
"     bn - buffer next
"     br - buffer rewind
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bc :bdelete<CR>
nnoremap <leader>bb :CtrlPBuffer<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>br :brewind<CR>

" c - compilation
"   cc - compile
"   cC - compile with arguments
"   cd - close compilation window
nnoremap <leader>cc :Make<CR>
nnoremap <leader>cC :Make 
nnoremap <leader>cd :cclose<CR> 

" errors
"   en - goto next error
"   ep - goto previous error
"   ed - close error window
"   ee - open error window
nnoremap <leader>en :cnext<CR>
nnoremap <leader>ep :cprev<CR>
nnoremap <leader>ed :cclose<CR>
nnoremap <leader>ee :copen<CR>

" d - delete
"     df - delete function
"     dw - delete trailing whitespace
"     dl - delete empty lines
"     do - only one space
nnoremap <leader>dw :%s/\s\+$//e<CR>
" TODO: implement df - delete function
" TODO: implement dl - delete empty lines
" TODO: implement do - only one space

" f - files
"     fS - save all files
"     fW - write out as sudo
"     fb - find bookmarks
"     ff - CtrlP
"     fj - file jump (NerdTree locate file)
"     fl - open last file
"     fr - CtrlPMRU
"     fs - file save
"     ft - NerdTree toggle
"     fv - .vimrc
nnoremap <leader>fS :wall<CR>
nnoremap <leader>fW :w !sudo tee % >/dev/null<CR>
nnoremap <leader>fb :marks<CR>
nnoremap <leader>ff :CtrlP<CR>
nnoremap <leader>fj :NERDTreeFind<CR>
nnoremap <leader>fl :execute "rightbelow vsplit " . bufname('#')<CR>
nnoremap <leader>fr :CtrlPMRUFiles<CR>
nnoremap <leader>fs :update<CR>
nnoremap <leader>ft :NERDTreeToggle<CR>
nnoremap <leader>fv :tabedit ~/.vimrc<CR>

" g - git
"     gb - git blame
"     gc - git commit
"     gd - git diff
"     gl - git log
"     go - git diff origin
"     gp - git stash pop
"     gr - git rebase master
"     gs - git status
"     gv - git svnup
"     gz - git stash
nnoremap <leader>g1 :Git log --oneline<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gf :Gpull<CR>
nnoremap <leader>gl :Gllog<CR>
nnoremap <leader>go :Gdiff origin<CR>
nnoremap <leader>gr :Git rebase master
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gv :Git svnup<CR>
nnoremap <leader>gz :Git stash<CR>

" h - help
"     hh - help
"     ht - help tab
"     hv - help vertically
"     hf - help functions
"     hs - help vim scripts
"     hr - help regexps
"     hw - help for current word
"     hm - manual for current word
"     hk - help with keymap
nnoremap <leader>hh :help
nnoremap <leader>ht :tab help 
nnoremap <leader>hs :split help
nnoremap <leader>hv :vert help 
nnoremap <expr> <leader>hi ':tab help ' . expand("<cword>")
nnoremap <expr> <leader>hm ':tab Man ' . expand("<cword>")
nnoremap <leader>hf :tab help functions<CR>
nnoremap <leader>hr :vert help pattern-overview<CR>
nnoremap <leader>hk :map 

" j - jumps
"     ji - jump to tag (in buffer)
"     ju - jump to undo
nnoremap <leader>ji :CtrlPBufTag<CR>
nnoremap <leader>ju :CtrlPUndo<CR>

" l - locations
"     lb - previous location file
"     lc - close location list
"     lf - next location file
"     ll - open location list
"     ln - next location
"     lp - previous location
"     lr - rewind location list
nnoremap <leader>lb :lpfile<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>ld :lclose<CR>
nnoremap <leader>lf :lnfile<CR>
nnoremap <leader>ll :lwindow 15<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprev<CR>
nnoremap <leader>lr :lrewind<CR>

" p - project
"     pf - open file at project root
"     pi - find project tag
"     pt - project tree
"     pT - test project
"     pc - project compile
"     ps - project search
"     pS - project search with current word
nnoremap <leader>pf :CtrlPRoot<CR>
nnoremap <leader>pi :CtrlPTag<CR>
nnoremap <leader>pt :NERDTree ~/cpp<CR>
nnoremap <leader>pm :Make<CR>
nnoremap <leader>pT :Focus ~/cpp/ecn_unit_test/parallel_test -1<CR>:Dispatch!<CR>
nnoremap <leader>ps :Glgrep 
nnoremap <leader>pS :Glgrep <C-r>=expand("<cword>")<CR>

" q - quicklist
"     qb - previous file
"     qc - close quicklist
"     qf - next file
"     qn - next item
"     qp - previous item
"     qq - open quicklist
"     qr - rewind quicklist
nnoremap <leader>qb :cpfile<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qd :cclose<CR>
nnoremap <leader>qf :cnfile<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qq :cwindow 15<CR>
nnoremap <leader>qr :crewind<CR>

" r - registers/resume
"     rr - show registers
"     ry - show yank kill ring
"     rl - resume last completion window
"     rb - show bookmarks
nnoremap <leader>rr :registers<CR>
nnoremap <leader>ry :CtrlPYankring<CR>
nnoremap <leader>rl :CtrlPLastMode<CR>
nnoremap <leader>rb :marks<CR>

" u - unit tests
"     ut - run unit tests (dispatch!)
"     up - run parallel unit test
"     uf - focus on unit test
nnoremap <leader>ut :Dispatch!<CR>
nnoremap <leader>up :FocusDispatch ~/cpp/ecn_unit_test/parallel_test -1<CR>
nnoremap <leader>uf :FocusDispatch ~/cpp/ecn_unit_test/parallel_test -1 -t 

" s - search/substitute
"     ss - search
"     sS - search with current word
"     sD - search with current word in current directory
"     sr - search and replace whole file
"     sh - search and replace from here
"     sv - subvert
nnoremap <leader>ss :LAck 
nnoremap <leader>sS :LAck <C-r>=expand("<cword>")<CR> 
nnoremap <leader>sD :LAck <C-r>=expand("<cword>")<CR> <C-r>=expand('%:h').'/'<CR>
nnoremap <leader>sr :%s/\v
nnoremap <leader>sR :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <leader>sh :.,$s/\v
nnoremap <leader>sv :Subvert/

" t - toggle
"     th - toggle highlight
"     tw - toggle whitespace
"     tn - toggle line numbers
"     tt - toggle NERDTree
"     tc - toggle cursor line
"     tl - toggle line wrap
nmap <leader>th <Plug>(LoupeClearHighlight)
nnoremap <leader>tw :set list!<CR>
nnoremap <leader>tn :set relativenumber!<CR>:set number!<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tc :set cursorline!<CR>
nnoremap <leader>tl :set wrap!<CR>

" w - window
nnoremap <leader>w <C-w>

" x - modification
"     x= - align on -
"     x: - align on :
"     x, - align on ,
"     xs - squash space
"     xo - just one line
noremap <leader>x= :Tabularize /=<CR>
noremap <leader>x: :Tabularize /:\zs<CR>
noremap <leader>x, :Tabularize /,\zs/l0r1<CR>
noremap <leader>xs :call SquashSpace()<CR>
noremap <leader>xo cip<Esc>

" z - folds
"   zz - toggle current fold
"   zi - fold by indent
"   zm - fold by marker
"   zu - fold manually
noremap <leader>zz zA
noremap <leader>zi :setlocal foldmethod=indent<CR>
noremap <leader>zm :setlocal foldmethod=marker<CR>
noremap <leader>zu :setlocal foldmethod=manual<CR>
" 1}}}

" Projectionist heuristics {{{1
" Setup projectionist heuristics (see alternate 'a' mnemonic above)
let g:projectionist_heuristics = {
\   '*': {
\       '*.cpp': {
\           'alternate': '{}.h',
\           'type': 'source',
\       },
\       '*_inline.h': {
\           'alternate': [
\               '{}.cpp',
\               '{}.h',
\           ],
\           'type': 'inline',
\       },
\       '*.h': {
\           'alternate': [
\               '{}_inline.h',
\               '{}.cpp',
\           ],
\           'type': 'header',
\       },
\       '*.inc': {
\           'alternate': [
\               '{}.h',
\               '{}.cpp',
\           ],
\           'type': 'inc'
\       },
\   },
\}
" }}}

" Miscellaneous {{{1

" Replace many spaces with one in Vim
" With help from Al: http://stackoverflow.com/questions/1228100/substituting-zero-width-match-in-vim-script

function! SquashSpace()
    " Get the current contents of the current line
    let current_line = getline(".")

    " Get the current cursor position
    let cursor_position = getpos(".")

    " Generate a match using the column number of the current cursor position
    let matchre = '\s*\%' . cursor_position[2] . 'c\s*'
    let pos = match(current_line, matchre) + 2

    " Modify the line by replacing with one space
    let modified_line = substitute(current_line, matchre, " ", "")

    " Modify the cursor position to handle the change in string length
    let cursor_position[2] = pos

    " Set the line in the window
    call setline(".", modified_line)

    " Reset the cursor position
    call setpos(".", cursor_position)
endfunction

" 1}}}
