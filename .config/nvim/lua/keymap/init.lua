-- Keymaps 

local homdir = os.getenv('HOME')
local map = vim.api.nvim_set_keymap

-- Remove <Space> as leader key in normal mode, then
-- set comma <,> as leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ','

-- Searh for files from current working directory
map('n', '<leader>t', ':Files<CR>', {})
-- Open buffer list
map('n', '<leader>b', ':Buffers<CR>', {})
-- Open init.lua 
-- TODO Dynamic file path
map('n', '<leader>,', ':e ~/.config/nvim/init.lua <CR>', {})
-- Open register
map('n', '<leader>R', ':reg <CR>', { noremap = true })
-- Copy current file path
map('n', '<leader>cp', ':let @*=expand("%:p") <CR>', {})
-- Self-explanatory
map('i', 'jk', '<Esc>', {})
-- Map semi-colon to colon
map('n', ';', ':', {})
-- Move down visual (screen) lines instead of physical lines
map('n', 'j', 'gj', { noremap = true })
-- Remove search match highlights
map('n', '<leader><space>', ':let@/=""<CR>', { noremap = true })
-- Close buffer
map('n', '<leader>x', ':bd <CR>', { noremap = true })

-- Plugin-specific
-- Go to definition using coc.nvim
map('n', 'gd', '<Plug>(coc-definition)', {})
-- Vim-sneak
map('n', 'f', '<Plug>Sneak_s', {})
map('n', 'F', '<Plug>Sneak_S', {})
