"=============================================================================
" dark_powered.vim --- Dark powered mode of SpaceVim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================


" SpaceVim Options: {{{
let g:spacevim_enable_debug = 1
let g:spacevim_realtime_leader_guide = 1
let g:spacevim_enable_tabline_filetype_icon = 0
let g:spacevim_enable_statusline_display_mode = 0
let g:spacevim_enable_os_fileformat_icon = 1
let g:spacevim_buffer_index_type = 1
let g:spacevim_enable_vimfiler_welcome = 1
let g:spacevim_default_indent = 4
let g:spacevim_colorscheme = 'base16-tomorrow-night'
let g:spacevim_statusline_unicode_symbols = 0
let g:spacevim_buffer_index_type = 4
let g:spacevim_windows_index_type = 3
let g:spacevim_github_username = 'mburrows'
let g:spacevim_filemanager = 'nerdtree'
let g:spacevim_windows_smartclose = ''

let g:spacevim_custom_plugins = [
\['chriskempson/base16-vim'],
\['edkolev/tmuxline.vim'],
\['vim-scripts/argtextobj.vim'],
\['tpope/vim-unimpaired'],
\['tpope/vim-abolish'],
\['dag/vim-fish'],
\]
" }}}

" SpaceVim Layers: {{{
call SpaceVim#layers#load('ctrlp')
call SpaceVim#layers#load('git')
call SpaceVim#layers#load('VersionControl')
call SpaceVim#layers#load('tags')
call SpaceVim#layers#load('github')
call SpaceVim#layers#load('tmux')
call SpaceVim#layers#load('shell')
call SpaceVim#layers#load('incsearch')
call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#vim')

call SpaceVim#layers#load('autocomplete', {
            \ 'auto-completion-return-key-behavior' : 'complete',
            \ 'auto-completion-complete-with-key-sequence' : 'jk',
            \ 'auto-completion-complete-with-key-sequence-delay' : 0.2,
            \ })
" }}}

" Custom keybindings {{{
call SpaceVim#custom#SPC('nnoremap', ['f', 'j'], 'NERDTreeFind', 'jump to file in tree', 1)
call SpaceVim#custom#SPC('nnoremap', ['a', 'a'], 'A', 'alternate file', 1)
call SpaceVim#custom#SPC('nnoremap', ['p', 'm'], 'Neomake!', 'project make', 1)
call SpaceVim#custom#SPC('nnoremap', ['b', 'b'], 'CtrlPBuffer', 'select buffer', 1)
call SpaceVim#custom#SPC('nnoremap', ['j', 'i'], 'CtrlPBufTag', 'jump to a tag', 1)
call SpaceVim#custom#SPC('nnoremap', ['p', 'i'], 'CtrlPTag', 'find project tag', 1)

" Map return key to replay last macro
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" Map cursor keys to quickfix navigation
nnoremap <silent> <Up>    :cprevious<CR>
nnoremap <silent> <Down>  :cnext<CR>
nnoremap <silent> <Left>  :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

cnoremap %% <C-R>=expand('%:h').'/'<CR>
" }}}

" Auto commands {{{
augroup filetype_cpp
    autocmd!

    autocmd BufNewFile,BufRead *.inc   setfiletype cpp
    autocmd BufNewFile,BufRead */ecn/* compiler gcc
    autocmd BufNewFile,BufRead */ecn/* setlocal makeprg=~/cpp/bb\ debug\ -j32\ -o\ /tmp/build/clang
    autocmd BufNewFile,BufRead */ecn/* :NeomakeDisableBuffer

    autocmd FileType cpp  setlocal commentstring=//\ %s
augroup END

augroup neomake_hooks
    autocmd!
    autocmd User NeomakeJobFinished :echom "Build complete"
augroup END
" }}}

" Projectionist heuristics {{{
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

" Miscellaneous {{{
set path+=~/cpp/**
set wildmode=longest,list,full

let g:NERDTreeWinSize = 60
let g:ctrlp_max_files = 20000
" }}}
