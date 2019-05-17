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
Plug '/usr/local/opt/fzf'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim' 
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-latex/vim-latex', {'for': 'tex'}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vimwiki/vimwiki'
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()
filetype plugin indent on
" }}}
" Editor settings {{{
set autoindent
set autoread
set backspace=indent,eol,start
set cmdheight=2
set cursorline 
set encoding=utf-8
set hidden
set hlsearch
set lazyredraw
set linebreak
set mouse=n
set nospell
set novisualbell
set omnifunc=syntaxcomplete#Complete
set relativenumber
set ruler
set splitbelow
set splitright
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set textwidth=0 " No autowrap
set title 
set viminfo=""
set virtualedit=block
set wrap
" Command mode smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END
" }}}
" Wildmenu settings {{{
set wildmenu " turn on command line completion wild style
set wildignore=*.a,*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.DS_Store " OSX bullshit
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
set wildignore+=*.luac " Lua byte code
set wildignore+=migrations " Django migrations
set wildignore+=*.orig " Merge resolution file
set wildignore+=*.pdf,*.zip,*.so " binaries
set wildignore+=*.pyc,*.pyo " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.swp,*.bak " ignore these
set wildignore+=*.sw? " Vim swap files
set wildignore+=**/vendor " Ignore vendor directory
set wildmode=list:longest " turn on wild mode full match only"
" }}}
" UI Settings {{{
set number
set path+=**
set showcmd
set showmatch
set laststatus=2
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set colorcolumn=80
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
" Theme settings {{{
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
" Markdown settings {{{
let g:vim_markdown_folding_disabled=0
let g:vim_markdown_frontmatter=1
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
let mapleader = 'L'

nnoremap <Leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>

" Search for files from root directory
nnoremap <Leader>T :Files ~<CR>

" Search for files from current workign directory
nnoremap <Leader>t :Files<CR>

" Open Buffers list
nnoremap <Leader>b :Buffers<CR> 

" Quick switch
nnoremap <Leader>q :b#<CR>

" Close buffer
nnoremap <leader>x :bd<CR>

" Opening a single file
nnoremap <Leader>e :e **/

" make file
nnoremap <leader>m :make<cr>

" Remove highlighted search results
nnoremap <Leader><space> :nohlsearch<bar>:echo<cr>

" Edit .vimrc
nnoremap <Leader>, :e ~/.vimrc<CR>

" Open ctags
nnoremap <Leader>j :Tags<CR>

" Undocumented assignments from plugins
" <Leader>p - Run Prettier
" }}}

