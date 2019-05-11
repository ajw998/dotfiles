set nocompatible
set number
set relativenumber

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
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'
call plug#end()

filetype plugin indent on

" Set mapleader
" You may find out the mapleader by typing ``echo mapleader``
" in command mode
let mapleader = ','

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

set hlsearch
set mouse=n

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_liststyle = 3

" Colour scheme
" UI and lightline
" Colourscheme must be declared 
" before setting background to dark
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_termcolors=256
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ }
set bg=dark
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
" hi Normal guibg=NONE ctermbg=NONE

" Filetype coercion 
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.markdown set ft=markdown
autocmd BufNewFile,BufRead *.md set ft=markdown

" Syntax coercion
au BufNewFile,BufRead * if &syntax == '' | set syntax=markdown | endif

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

" ProseMode function
function! ProseMode() 
    call goyo#execute(0, [])
    set spell noci nosi noai nolist noshowmode noshowcmd
    colorscheme gruvbox
    set bg=dark
    let g:gruvbox_contrast_dark = 'hard'
endfunction

command! ProseMode call ProseMode()
nnoremap \p :ProseMode<CR>

" Command mode smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" Change fzf colour to match gruvbox theme
let g:fzf_colors = {
    \ 'fg':      ['fg', 'GruvboxGray'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'GruvboxRed'],
    \ 'fg+':     ['fg', 'GruvboxGreen'],
    \ 'bg+':     ['bg', 'GruvboxBg1'],
    \ 'hl+':     ['fg', 'GruvboxRed'],
    \ 'info':    ['fg', 'GruvboxOrange'],
    \ 'prompt':  ['fg', 'GruvboxBlue'],
    \ 'header':  ['fg', 'GruvboxBlue'],
    \ 'pointer': ['fg', 'Error'],
    \ 'marker':  ['fg', 'Error'],
    \ 'spinner': ['fg', 'Statement'],
    \ }

"============================== 
" Leader Key mappings
"==============================
"
" Search for files
" Typing ,t will trigger fzf search
nnoremap <Leader>t :Files<CR>

" Quick saving
nnoremap <Leader>w :w<CR>
