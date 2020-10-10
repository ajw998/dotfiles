"""""""""""""""""""""""""""""
"       VIM SETTINGS        "
"""""""""""""""""""""""""""""
" Pre-plugin settings {{{
set nocompatible
filetype off
syntax off

" This must be disabled before loading vim-polyglot
let g:polyglot_disabled = ['markdown']
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
Plug 'editorconfig/editorconfig-vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kovisoft/slimv'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
call plug#end()
filetype plugin indent on
" }}}
" Editor settings {{{
set autoindent
set autoread
set backspace=indent,eol,start
if has('macunix')
	set backupdir=/private/tmp
else
	set backupdir=~/.vim/backup/
endif
set cmdheight=2
set cursorline
set directory=~/.vim/swap
set encoding=utf-8
set guitablabel=\[%N\]\ %t\ %M 
set hidden
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set linebreak
set matchtime=2
set modelines=0
set mouse=n
set nospell
set novisualbell
set omnifunc=syntaxcomplete#Complete
set relativenumber
set ruler
set shell=/bin/zsh
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
set includeexpr=substitute(substitute(v:fname,'^\\~\/','resources/assets/js/',''),'^\\~sass/\\(.*\\)/\\(.*\\)$','resources/assets/sass/\\1/_\\2','')
set suffixesadd=.js,.vue,.scss
set showcmd
set showmatch
set laststatus=2
set colorcolumn=80
set list
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set showbreak=↪ 
set wildmode=full
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
" }}}
" Folding {{{
" set foldenable
" set foldmethod=syntax
" }}}
" Theme settings {{{
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=0
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif
" Colourscheme must be declared
" before setting background to dark
syntax enable 
try
	colorscheme monokai-pro-octagon
	" set background=dark
	" " Transparent background
	" hi Normal guibg=#282a3a ctermbg=#000000
catch /^Vim\%((\a\+)\)\=:E185/
	" colorscheme ron
endtry
" }}}
" Statusline settings {{{
au InsertEnter * hi User1 guifg=black guibg=#d7afff ctermfg=black ctermbg=blue
au InsertLeave * hi User1 guifg=black guibg=#8fbfdc ctermfg=black ctermbg=green

let g:currentmode={ 'n' : 'Normal', 'no' : 'N·Operator Pending', 'v' : 'Visual', 'V' : 'V·Line', '^V' : 'V·Block', 's' : 'Select', 'S': 'S·Line', '^S' : 'S·Block', 'i' : 'Insert', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}
function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

hi User1 cterm=bold guifg=black guibg=#8fbfdc ctermfg=black ctermbg=green

" Status bar colour change
if version >= 700
    " Pass
    " See this https://stackoverflow.com/questions/11147157/vim-change-the-status-line-color-in-insert-mode
    endif
set statusline=
set statusline+=%1*\ %{ModeCurrent()}\        " Show current mode
set statusline+=%2*\ %f\                      " Current file path
set statusline+=%3*\ %{FugitiveStatusline()}
set statusline+=%m                            " Modified flag
set statusline+=%=                            " Switch to the right side
set statusline+=%l:%L
set statusline+=\ \  
set statusline+=\ %p                          " Percentage through file in lines
set statusline+=\ \  
set statusline+=%3*\ %y\ %*                   " Filetype
set noshowmode                                " Remove --INSERT-- on statusline
" }}}
" Filetype settings {{{
" Rust
let g:rustfmt_autosave = 1

" Ocaml
augroup ocaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
autocmd FileType ocaml source '"$(opam config var prefix)"'/share/typerex/ocp-indent/ocp-indent.vim
augroup END

" vimrc
augroup vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END 

" Plaintext
augroup text
    autocmd!
    autocmd FileType text setlocal listchars= syntax=off spell tw=79
augroup END

" Markdown
augroup markdown
	autocmd!
	autocmd BufNewFile,BufRead *.markdown set ft=markdown
	autocmd BufNewFile,BufRead *.md set ft=markdown
	autocmd FileType markdown let b:coc_suggest_disable = 1
	autocmd FileType markdown setlocal spell tw=79
	autocmd FileType vimwiki let b:coc_suggest_disable = 1
augroup END

" EJS
autocmd BufNewFile,BufRead *.ejs set ft=html

" Proper PEP8 implementation for python
augroup python
autocmd BufNewFile,BufRead *.py
            \  setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent
augroup END
" }}}
" Vim Sneak settings {{{
let g:sneak#use_ic_scs=1
let g:sneak#label=1
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
" Sneak
nmap <expr> <Tab> sneak#is_sneaking() ? '<Plug>Sneak_;' : '<Tab>'
" }}}
" coc.nvim settings {{{
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"})
"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
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
fun! JumpToDef()
	if exists("*GotoDefinition_" . &filetype)
		call GotoDefinition_{&filetype}()
	else
		exe "norm! \<C-]>"
	endif
endf

" Jump to tag
nmap <silent> gd <Plug>(coc-definition)
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" View all errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

" Highlight symbol under cursor
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<CR>
" }}}
" FZF settings {{{
" Enable popup
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" }}}
" Alternate files {{{
" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction
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

" Disable Ex mode
nmap Q <Nop>

" Jump to end of line in insert mode
inoremap <C-e><C-e> <C-o>$

nnoremap ;; ;

" Group comment
" Moving lines
" Source: https://vi.stackexchange.com/questions/2674/how-can-i-easily-move-a-line
if has('macunix')
	nnoremap ∆ :m . +1<CR>==
	nnoremap ˚ :m . -2<CR>==
	vnoremap ∆ :m '>+1<CR>gv=gv
	vnoremap ˚ :m '<-2<CR>gv=gv
endif

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

" Snap out of autocomplete brackets
inoremap <C-e> <C-o>$

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
nnoremap <Leader>b :Buffers<CR>

" Quick switch
nnoremap <Leader>q :b#<CR>

" Close buffer
nnoremap <Leader>x :bd<CR>

" Opening a single file
nnoremap <Leader>e :e **/

" Show marks
nnoremap <Leader>m :Marks<CR>

" Remove highlighted search results
" nnoremap <Leader><space> :nohlsearch<bar>:echo<cr>
nnoremap <Leader><Space> :let@/=""<CR>

" Edit .vimrc
nnoremap <Leader>, :e ~/.vimrc<CR>

" Open ctags
nnoremap <Leader>j :Tags<CR>

" Rename current word (coc.nvim)
nmap <leader>rn <Plug>(coc-rename)

" Open register
nnoremap <leader>R :reg<CR>

" Controlling tabs
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <silent> <A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Open netrw in current directory with - 
nnoremap - :e %:p:h<CR>

" Open alternate file
nnoremap <Leader>al :w<cr>:call AltCommand(expand('%'), ':e')<cr>

" Ripgrep find word under cursor 
nnoremap <Leader>fw :Rg <C-R>=expand("<cword>")<CR><CR>

" Copy current file path
nnoremap <leader>cp :let @*=expand("%:p")<CR>

" Vim fugitive (git-stage)
nnoremap <Leader>gw :Gwrite<CR>

" Vim fugitive (git-commit)
nnoremap <Leader>gc :Gcommit<CR>

" Execute the line under cursor
nnoremap <Leader>e :exe getline(line('.'))<CR>

" }}}

