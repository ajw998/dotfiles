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
set nocompatible
filetype off
syntax off
" }}}
" Variable Declaration {{{
let TODO_LIST='~/knowledgeBase/todo.md'
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
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'lervag/vimtex'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
Plug 'zah/nim.vim'
call plug#end()
filetype plugin indent on
syntax enable 
" }}}
" Editor settings {{{
set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=/private/tmp
set cmdheight=2
set cursorline
set directory=~/.vim/swap
set encoding=utf-8
set hidden
set hlsearch
set ignorecase
set lazyredraw
set linebreak
set matchtime=2
set mouse=n
set nospell
set novisualbell
set omnifunc=syntaxcomplete#Complete
set relativenumber
set ruler
set smartcase
set splitbelow 
set splitright
set tabstop=4 softtabstop=0 shiftwidth=4 smarttab
set textwidth=0 " No autowrap
set title
set viminfo=""
set virtualedit=block
set wrap
" Workaround for being stuck in Insert(paste) mode
au InsertLeave * set nopaste
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
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set showbreak=↪ 
set colorcolumn=80
" }}}
" Cursor setting {{{
" highlight Cursor guifg=white guibg=black
" highlight iCursor guifg=white guibg=steelblue
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
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
" }}}
" Folding {{{
set foldenable
set foldmethod=manual
" }}}
" Theme settings {{{
" Colourscheme must be declared
" before setting background to dark
colorscheme nord 
" Transparent background
hi Normal guibg=NONE ctermbg=NONE
" }}}
" Statusline settings {{{
" TODO: Git status, current mode colour 
" Highlighting groups
let g:currentmode={ 'n' : 'Normal ', 'no' : 'N·Operator Pending ', 'v' : 'Visual ', 'V' : 'V·Line ', '^V' : 'V·Block ', 's' : 'Select ', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'Insert ', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}
function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction


hi User1 cterm=bold  ctermbg=12
hi User3 ctermfg=white ctermbg=12
" Status bar colour change
if version >= 700
    " Pass
    " See this https://stackoverflow.com/questions/11147157/vim-change-the-status-line-color-in-insert-mode
    endif
set statusline=
set statusline+=%1*\ %{ModeCurrent()}\%*      " Show current mode
set statusline+=\ \  
set statusline+=%f                      " Current file path
set statusline+=\ \  
set statusline+=%m                      " Modified flag
set statusline+=%=                      " Switch to the right side
set statusline+=%l:%L
set statusline+=\ \  
set statusline+=\ %p                      " Percentage through file in lines
set statusline+=\ \  
set statusline+=%3*\ %y\ %*                       " Filetype
" }}}
" Custom mappings {{{
"
imap jk <Esc>
nmap ; :

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

" Disable Ex mode
nmap Q <Nop>

" Jump to end of line in insert mode
inoremap <C-e><C-e> <C-o>$

" Group comment
" Moving lines
" TODO - Cross-platform compatibility (this is specifically for macOS)
" Source: https://vi.stackexchange.com/questions/2674/how-can-i-easily-move-a-line
nnoremap ∆ :m . +1<CR>==
nnoremap ˚ :m . -2<CR>==
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Omnicompletion hotkeys
inoremap <silent> ,f <C-x><C-f>
inoremap <silent> ,i <C-x><C-i>
inoremap <silent> ,l <C-x><C-l>
inoremap <silent> ,n <C-x><C-n>
inoremap <silent> ,o <C-x><C-o>
inoremap <silent> ,t <C-x><C-]>
inoremap <silent> ,u <C-x><C-u>

" Generate ctags
nnoremap \r :!ctags -R .<CR>
" Strip whitespace
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<CR>
        normal `z
    endif
endfunction
command! StripTrailingWhitespace call StripTrailingWhitespace()
nnoremap <F3> :StripTrailingWhitespace<CR>

" Undo Tree
nnoremap <F5> :UndotreeToggle<CR>

" Sneak
nmap <expr> ` sneak#is_sneaking() ? '<Plug>Sneak_;' : '<Tab>'

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
" }}}
" Filetype settings {{{
" C++
autocmd FileType c,cpp setlocal path+=/usr/include include&

" Markdown
autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType vimwiki let b:coc_suggest_disable = 1

" vimrc
augroup vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END 

augroup text
    autocmd!
    autocmd FileType text setlocal listchars= syntax=off spell
augroup END

" Markdown
augroup markdown
	autocmd!
	autocmd FileType markdown setlocal spell
augroup END

" EJS
autocmd BufNewFile,BufRead *.ejs set ft=html

" Vimrc
autocmd BufNewFile,BufRead *.markdown set ft=markdown
autocmd BufNewFile,BufRead *.md set ft=markdown

" Syntax coercion (default to markdown)
au BufNewFile,BufRead * if &syntax == '' | set syntax=markdown | endif

" Proper PEP8 implementation for python
autocmd BufNewFile,BufRead *.py
            \  setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent
" }}}
" Undotree settings {{{
let g:undotree_WindowLayout=1
" }}}
" Vim Sneak settings {{{
let g:sneak#use_ic_scs=1
" }}}
" coc.nvim settings {{{
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"})
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction"

" Close preview window when done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}
" Language settings {{{
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i
" }}}
" Vimtex settings {{{
let g:vimtex_enabled=1
let g:vimtex_latexmk_continuous=0
let g:vimtex_compiler_enabled=1
let g:tex_flavor='tex'
let g:vimtex_compiler_latexmk ={ 
            \'build_dir' : 'build'    
            \}
" }}}
" Vimwiki settings {{{
let g:vimwiki_list = [{'path': '~/knowledgeBase/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0
" }}}
" Leader bindings {{{
"
" Set map Leader to ,
let mapleader = ','

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

" Show marks
nnoremap <Leader>m :Marks<CR>

" make file
nnoremap <Leader>M :make<cr>

" Remove highlighted search results
" nnoremap <Leader><space> :nohlsearch<bar>:echo<cr>
nnoremap <Leader><Space> :let@/=""<CR>

" Edit .vimrc
nnoremap <Leader>, :e ~/.vimrc<CR>

" Open ctags
nnoremap <Leader>j :Tags<CR>

" Rename current word (coc.nvim)
nmap <leader>rn <Plug>(coc-rename)

" Undocumented assignments from plugins
" <Leader>p - Run Prettier
" }}}

