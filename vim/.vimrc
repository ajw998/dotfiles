set nocompatible
set number

syntax on 
filetype off

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'pangloss/vim-javascript'
call plug#end()

filetype plugin indent on
let g:dracula_italic=0

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set wrap
set linebreak

set encoding=utf-8
set colorcolumn=80
set statusline=%f
set viminfo=""

set splitbelow
set splitright

set path+=**
set wildmenu

set background=dark
set termguicolors
colorscheme dracula 

set backspace=2

imap jk <Esc>
nnoremap ; :
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Moving down visual (screen) lines instead of physical line
nnoremap j gj
nnoremap k gk

" Command to toggle colorcolumn
command! ToggleCC :let &cc = &cc == '' ? '70, 80, 90' : ''
nnoremap <F2> :let &cc = &cc == '' ? '70,80,90' : ''<CR>

" Transparent background
hi Normal guibg=NONE ctermbg=NONE

autocmd BufNewFile,BufRead *.json set ft=javascript

