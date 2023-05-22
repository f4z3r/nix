" ===========================================================================
" ============================== Treesitter =================================
" ===========================================================================

lua << EOF
require('nvim-treesitter.install').prefer_git = true
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {},
}
EOF
