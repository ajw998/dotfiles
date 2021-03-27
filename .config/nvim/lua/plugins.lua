local vim = vim

-- Source: https://github.com/junegunn/vim-plug/issues/912
local function plug(path, config)
  vim.validate {
    path = {path, 's'};
    config = {config, vim.tbl_islist, 'an array of packages'};
  }
  vim.fn["plug#begin"](path)
  for _, v in ipairs(config) do
    if type(v) == 'string' then
      vim.fn["plug#"](v)
    elseif type(v) == 'table' then
      local p = v[1]
      assert(p, 'Must specify package as first index.')
      v[1] = nil
      vim.fn["plug#"](p, v)
      v[1] = p
    end
  end
  vim.fn["plug#end"]()
end

plug('~/.config/nvim/plugged', {
    'nvim-treesitter/nvim-treesitter';
    'nvim-treesitter/playground';
    'editorconfig/editorconfig-vim';
    'junegunn/fzf';
    'junegunn/fzf.vim';
    'justinmk/vim-sneak';
    { 'neoclide/coc.nvim',  branch = 'release' };
    'tpope/vim-commentary';
    'tpope/vim-eunuch';
    'tpope/vim-fugitive';
    'tpope/vim-surround';
    'tpope/vim-unimpaired';
    'hrsh7th/vim-vsnip';
    'hrsh7th/vim-vsnip-integ';
    'sheerun/vim-polyglot';
    'neovim/nvim-lspconfig';
})

