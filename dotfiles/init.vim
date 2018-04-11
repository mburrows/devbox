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
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_enable_statusline_display_mode = 0
let g:spacevim_enable_os_fileformat_icon = 1
let g:spacevim_buffer_index_type = 1
let g:spacevim_enable_vimfiler_welcome = 1
let g:spacevim_enable_debug = 1
let g:spacevim_default_indent = 4
let g:spacevim_colorscheme = 'base16-tomorrow-night'
let g:spacevim_statusline_unicode_symbols = 0
let g:spacevim_buffer_index_type = 4
let g:spacevim_windows_index_type = 3
let g:spacevim_github_username = 'mburrows'
let g:spacevim_filemanager = 'nerdtree'
" }}}

" SpaceVim Layers: {{{
call SpaceVim#layers#load('denite')
call SpaceVim#layers#load('autocomplete')
call SpaceVim#layers#load('colorscheme')
call SpaceVim#layers#load('git')
call SpaceVim#layers#load('VersionControl')
call SpaceVim#layers#load('tags')
call SpaceVim#layers#load('github')
call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#vim')
" }}}

let g:spacevim_custom_plugins = [
\['chriskempson/base16-vim'],
\]

call SpaceVim#custom#SPC('nnoremap', ['f', 'j'], 'NERDTreeFind', 'Jump to file in tree', 1)
