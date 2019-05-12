set nocompatible
syntax enable 
filetype off
" Variable Declaration {{{
let TODO_LIST='~/vimwiki/todo.md'
" }}}
" Vim Plug {{{
" Automatic installation
 if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'vimwiki/vimwiki'
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
" }}}
" Editor Settings {{{
set splitbelow
set splitright
set hlsearch
set mouse=n
set backspace=indent,eol,start
set autoindent
set autoread
set lazyredraw
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set wrap
set linebreak
set cursorline 
set encoding=utf-8
set viminfo=""
set title 
set relativenumber
set cmdheight=2
" Command mode smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END
" }}}
" UI Settings {{{
set number
set path+=**
set wildmenu
set showcmd
set showmatch
set laststatus=2
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set colorcolumn=80
set statusline=%f
" }}}
" Netrw settings {{{
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
" }}}
" Folding {{{
set foldenable
set foldmethod=marker
" }}}
" Theme Settings {{{
" Colourscheme must be declared 
" before setting background to dark
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_termcolors=256
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ }
set bg=dark

" Transparent background
" hi Normal guibg=NONE ctermbg=NONE
" }}}
" Custom mappings {{{
"
imap jk <Esc>
nnoremap ; :
nnoremap <silent> <space> :nohlsearch<bar>:echo<cr>

" Moving down visual (screen) lines instead of physical line
nnoremap j gj
nnoremap k gk

" Command to toggle colorcolumn
let &cc = ''
nnoremap <F2> :let &cc = &cc == '' ? '70,80,90' : ''<CR>

" Open task list
function! LaunchTodo(path) 
    execute "vsplit" a:path
endfunction
command! LaunchTodo call LaunchTodo(TODO_LIST)
nnoremap TT :LaunchTodo<CR>
" Disable Ex mode
nmap Q <Nop>
" }}}
" Filetype settings {{{
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.markdown set ft=markdown
autocmd BufNewFile,BufRead *.md set ft=markdown
" Syntax coercion (default to markdown)
au BufNewFile,BufRead * if &syntax == '' | set syntax=markdown | endif

" Proper PEP8 implementation for python
autocmd BufNewFile,BufRead *.py
    \  setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent
" }}}
" ALE (Linting plugin) settings {{{
"
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
" }}}
" coc.vim settings {{{
"
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" }}} 
" Goyo.vim settings {{{
function! ProseMode() 
    call goyo#execute(0, [])
    set spell noci nosi noai nolist noshowmode noshowcmd
    colorscheme gruvbox
    set bg=dark
    let g:gruvbox_contrast_dark = 'hard'
endfunction

command! ProseMode call ProseMode()
nnoremap \p :ProseMode<CR>
" }}}
" FZF.vim settings {{{
"
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
" }}}
" Vimwiki Settings {{{ 
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" }}}
" Leader bindings {{{
"
" Set map leader to ,
let mapleader = ','

" Search for files from root directory
 nnoremap <Leader>T :Files ~<CR>

" Search for files from current workign directory
nnoremap <Leader>t :Files<CR>

" Cycling through buffers
nnoremap <Leader>b :Buffers<CR> 

" Quick saving
nnoremap <Leader>w :w<CR>

" Close buffer
 nnoremap <Leader>c :bd<CR>

" Switch between current and last buffer
nnoremap <Leader>. <C-^>
" }}}

