-- Get home directory path
local homedir = os.getenv("HOME")

-- Binding: Global options
local g = vim.o
-- Binding: Window-local options
local window = vim.wo
-- Binding: Buffer-local options
local buffer = vim.bo

-- Automatically read file if changed outside vim
g.autoread = true 
-- List of directories for the backup file
g.backupdir = '/private/tmp'
-- Number of screen lines to use for the command line
g.cmdheight = 2
g.directory = homedir .. '/.vim/swap'
-- Highlight all matches
g.hlsearch = true
-- Disable case sensitivity in search
g.ignorecase = true
-- Whether last window will have a status line
-- Disable this because we will create our own status line
g.laststatus = 0
-- Prevent screen from redrawing while executing macro
g.lazyredraw = true
-- Strings to use in 'list' mode and for the :list command
-- g.listchars = 'tab:→,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨↲'
-- Tenths of a second to show the matching parens. This is set only if
-- 'showmatch' is enabled
g.matchtime = 3
-- Turn off modeline
g.modeline = false
-- Enable mouse support only in 'Normal' mode (n)
g.mouse = 'n'
-- Show matching braces
g.showmatch = true
-- Set default shell
g.shell = '/bin/zsh'
-- String to put at the start of lines that have been wrapped
g.showbreak = '↪'
-- Override 'ignorecase' option if search contains upper case characters
g.smartcase = true
-- Split new window below the current one
g.splitbelow = true
-- Split new window to right of the current one
g.splitright = true
-- Title of the window will be set to the value of the 'titlestring'
g.title = true
-- Allow virtual editing in block mode
g.virtualedit = 'block'

-- Highlight the screenline of the cursor with the CursorLine
window.cursorline = true
-- Wrap long lines at a character in 'breakat'
window.linebreak = true
-- Disable spell check
window.spell = false
-- Relative line number
window.relativenumber = true
-- Change how text is displayed
window.wrap = true
-- Auto indent
buffer.autoindent = true
-- Number of spaces that a <Tab> in the file counts for
buffer.tabstop = 4
-- Number of spaces a <Tab> counts for while editing
buffer.softtabstop = 0
buffer.shiftwidth = 4
-- Use the appropriate number of spaces when expanding tabs
buffer.expandtab = true
-- Turn on Omni completion
buffer.omnifunc='syntaxcomplete#Complete'
