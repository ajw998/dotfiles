"""""""""""""""""""""""""""""
"       VIM SETTINGS        "
"""""""""""""""""""""""""""""
" Environment values (Must be at the top) {{{
" Scaffold this as a future foundation for cross-platform setup
function! Config_setEnv() abort
    if exists('g:env')
        return
    endif
    if has('win64') || has('win32') || has('win16')
        let g:env = 'WINDOWS'
    else
        let g:env = toupper(substitute(system('uname'), '\n', '', ''))
    endif
endfunction
call Config_setEnv()
" }}}
" Pre-plugin settings {{{
"
set nocompatible
syntax enable 
filetype off
" }}}
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
Plug 'mattn/emmet-vim' 
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'
Plug 'vim-latex/vim-latex', {'for': 'tex'}
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()
filetype plugin indent on
" }}}
" Editor Settings {{{
set splitbelow
set splitright
set hidden
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
set nospell
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
" Cursor setting {{{
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
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
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ }

function! LightlineBufferline()
    call bufferline#refresh_status()
    return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction
set bg=dark
command! LightlineReload call LightlineReload()
function! LightlineReload()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
" Transparent background
" hi Normal guibg=NONE ctermbg=NONE
" }}}
" Custom mappings {{{
"
imap jk <Esc>
nnoremap ; :

" Moving down visual (screen) lines instead of physical line
nnoremap j gj
nnoremap k gk

" Command to toggle colorcolumn
let &cc = ''
nnoremap <F2> :let &cc = &cc == '' ? '70,80,90' : ''<CR>

" Open task list
function! WikiSplit(path) 
    execute "vsplit" a:path
endfunction
command! WikiSplit call WikiSplit(TODO_LIST)
nnoremap TT :WikiSplit<CR>

" Open Diary List
" You could also use <Leader>wi to accomplish this
nnoremap TD :vsplit<bar>VimwikiDiaryIndex<CR>

" Open Diary
" Disable Ex mode
nmap Q <Nop>

" Group comment
" Moving lines
" TODO - Cross-platform compatibility (this is specifically for macOS)
" Source: https://vi.stackexchange.com/questions/2674/how-can-i-easily-move-a-line
nnoremap ∆ :m . +1<CR>==
nnoremap ˚ :m . -2<CR>==
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
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
let g:ale_lint_on_enter = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
let g:ale_linters = {
            \  'cpp':        ['clangtidy'],
            \  'css':        ['csslint'],
            \  'javascript': ['eslint'],
            \  'json':       ['jsonlint'],
            \  'markdown':   ['mdl'],
            \  'ruby':       ['rubocop'],
            \  'scss':       ['sasslint'],
            \  'yaml':       ['yamllint']
            \}
" }}}
" coc.nvim settings {{{
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" }}}
" Polyglot.vim settings {{{
let g:polyglot_disabled = ['md']
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
" vim-prettier settings {{{
" Use tabs over spaces
let g:prettier#config#tab_width = 4
let g:prettier#config#use_tabs = 'true'
let g:prettier#config#arrow_parens = 'avoid'
" }}}
" Vimwiki settings {{{ 
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
" }}}
" Emmet.vim settings {{{
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall

let g:user_emmet_leader_key='<C-x>'
" }}}
" Leader bindings {{{
"
" Set map Leader to ,
let mapleader = ','

" Search for files from root directory
nnoremap <Leader>T :Files ~<CR>

" Search for files from current workign directory
nnoremap <Leader>t :Files<CR>

" Open Buffers list
nnoremap <Leader>bs :Buffers<CR> 

" No name buffer
nnoremap <Leader>bc :enew<CR>

" Previous buffer
nnoremap <Leader>bb :b# <CR>

" Close buffer
nnoremap <Leader>bz :bd<CR>

" Quick saving
nnoremap <Leader>w :w<CR>

" Switch between current and last buffer
nnoremap <Leader>. <C-^>

" Remove highlighted search results
nnoremap <Leader><space> :nohlsearch<bar>:echo<cr>

" Edit .vimrc
nnoremap <Leader>, :e ~/.vimrc<CR>

" Open ctags
nnoremap <Leader>gs :Tags<CR>

" coc.vim
" Renaming symbols
 nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <Leader>lr <Plug>(coc-rename)
nmap <silent> <Leader>lf <Plug>(coc-references)

" Undocumented assignments from plugins
" <Leader>p - Run Prettier
" }}}

