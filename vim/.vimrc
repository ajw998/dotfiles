set nocompatible
set number

set cmdheight=2

syntax enable 
filetype off

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

filetype plugin indent on

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
set laststatus=2

" Colour scheme
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_termcolors=256

set backspace=2

imap jk <Esc>
nnoremap ; :
nnoremap <silent> <space> :nohlsearch<bar>:echo<cr>


" Moving down visual (screen) lines instead of physical line
nnoremap j gj
nnoremap k gk

" Command to toggle colorcolumn
command! ToggleCC :let &cc = &cc == '' ? '70, 80, 90' : ''
nnoremap <F2> :let &cc = &cc == '' ? '70,80,90' : ''<CR>

" Transparent background
hi Normal guibg=NONE ctermbg=NONE

autocmd BufNewFile,BufRead *.json set ft=javascript

" ALE (Linting plugin) settings
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" Tab completion for coc.vim
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Command mode smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END
