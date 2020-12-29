lua << EOF
    vim.cmd 'packadd paq-nvim'
    local paq = require'paq-nvim'.paq

    -- Plugins 
    paq {'junegunn/fzf', hook = vim.fn['fzf#install']}
    paq {'junegunn/fzf.vim'}
    paq {'justinmk/vim-sneak'}
    paq {'tpope/vim-commentary'}
    paq {'tpope/vim-surround'}
    paq {'tpope/vim-unimpaired'}
    paq {'nvim-treesitter/nvim-treesitter', hook= vim.fn[':TSUpdate']}
 
EOF
