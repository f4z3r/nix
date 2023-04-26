" ===========================================================================
" ================================= Dein ====================================
" ===========================================================================

" Load polyglot_disables
source <sfile>:h/polyglot_disables.vim

if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" ==== Plugin Installs ==================================================={{{
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

" ================= Plugins =================
  " splash screen
  call dein#add('mhinz/vim-startify')

  " auto completion
  call dein#add('neoclide/coc.nvim',
        \{'merged': 0, 'rev': 'release'})

  " add snippets for coc
  call dein#add('honza/vim-snippets')

  " nice icon set for tabs and status line
  call dein#add('ryanoasis/vim-devicons')

  " asynchronous linting (and fixing) engine
  call dein#add('w0rp/ale')

  " netrw in buffer nagivation
  call dein#add('lambdalisue/nerdfont.vim')
  call dein#add('lambdalisue/fern.vim')
  call dein#add('lambdalisue/fern-git-status.vim')
  call dein#add('lambdalisue/fern-renderer-nerdfont.vim')

  " repeat plugin commands
  call dein#add('tpope/vim-repeat')

  " nice theme (not original for true haskell support)
  call dein#add('sainnhe/gruvbox-material')

  " comment things
  call dein#add('preservim/nerdcommenter')

  " git support
  call dein#add('tpope/vim-fugitive')

  " fuzzy search everything
  call dein#add('nvim-telescope/telescope-fzf-native.nvim',
        \{'build': 'make'})
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('nvim-telescope/telescope.nvim')
  call dein#add('fannheyward/telescope-coc.nvim')

  " provide nice surround commands
  call dein#add('tpope/vim-surround')

  " show indent guide
  call dein#add('Yggdroot/indentLine')

  " todo.txt
  call dein#add('freitass/todo.txt-vim',
        \{'on_ft': ['todo']})

  " required for markdown table formatting and alignment
  " Launch easy align with `ga`:
  "   vipga= (align on = inner paragraph)
  "   = Around the 1st occurrence
  "   2= Around the 2nd occurrence
  "   -= Around the last occurrence
  "   *= Around all occurrences
  "   **= Left/Right alternating alignment around all occurrences
  "   <Enter> Switching between left/right/center alignment mo
  call dein#add('junegunn/vim-easy-align')

  " language support (should be lazy by default)
  call dein#add('sheerun/vim-polyglot')

  " language support for d2 diagrams
  call dein#add('terrastruct/d2-vim')

  " EBNF support
  call dein#add('vim-scripts/ebnf.vim',
        \{'on_ft': 'ebnf'})

  " better OCaml support for indenting
  call dein#add('OCamlPro/ocp-indent',
        \{'on_ft': 'ocaml'})

  " polyglot does not come with proper julia syntax highlightling
  call dein#add('JuliaEditorSupport/julia-vim',
        \{'on_ft': 'julia'})

  " polyglot does not come with a java syntax highlightling
  call dein#add('uiiaoo/java-syntax.vim',
        \{'on_ft': 'java'})

  call dein#add('neoclide/jsonc.vim',
        \{'on_ft': 'json'})

  call dein#add('f4z3r/cheat.vim',
        \{'on_ft': 'cheat'})

  call dein#add('imsnif/kdl.vim',
        \{'on_ft': 'kdl'})

  " rainbow parentheses
  call dein#add('luochen1990/rainbow')

  " better targets
  call dein#add('wellle/targets.vim')
  call dein#add('michaeljsmith/vim-indent-object')

  " marks in gutter
  call dein#add('kshenoy/vim-signature')

  " git in gutter
  call dein#add('airblade/vim-gitgutter')

  " support <localleader>p and <localleader>P to cycle through yanks
  call dein#add('maxbrunsfeld/vim-yankstack')

  " highlight yanks
  call dein#add('machakann/vim-highlightedyank')

  " easy motion jumps (load after yankstack for mapping to work)
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('haya14busa/incsearch-easymotion.vim')
  call dein#add('easymotion/vim-easymotion')

  " golden ratio
  call dein#add('roman/golden-ratio',
        \{'on_cmd': 'GoldenRatioToggle'})

  " undo tree
  call dein#add('sjl/gundo.vim',
        \{'on_cmd': 'GundoToggle'})

  " tag file generation
  call dein#add('ludovicchabant/vim-gutentags')

  " tag tree
  call dein#add('majutsushi/tagbar',
        \{'on_cmd': 'TagbarToggle'})

  " split and join multi line statements
  call dein#add('andrewradev/splitjoin.vim',
        \{'on_ft': [
        \ 'c',
        \ 'cpp',
        \ 'elixir',
        \ 'python',
        \ 'rust',
        \ 'tex',
        \ 'vim',
        \ 'yaml',
        \ 'lua',
        \ 'perl',
        \ 'go',
        \]})

  " enable project local vimrcs (.lvimrc)
  call dein#add('embear/vim-localvimrc')

  " change case using single keystroke
  call dein#add('tpope/vim-abolish')

  " add closing ends upon opening
  call dein#add('tpope/vim-endwise',
        \{'on_ft': [
        \ 'c',
        \ 'cpp',
        \ 'bash',
        \ 'elixir',
        \ 'vim',
        \ 'lua',
        \ 'make',
        \ 'crystal',
        \]})

  " provide nice status line
  call dein#add('vim-airline/vim-airline')

  " move through camel or snake case
  call dein#add('bkad/camelcasemotion')

  " pomodoro
  call dein#add('rmolin88/pomodoro.vim')

  " enable colorscheme overrides
  call dein#add('vim-scripts/AfterColors.vim')

  " fix indentation on paste
  call dein#add('conradirwin/vim-bracketed-paste')

  " thesaurus lookup
  call dein#add('ron89/thesaurus_query.vim',
        \{'on_cmd': ['ThesaurusQueryReplaceCurrentWord',
        \            'ThesaurusQueryReplace',
        \            'Thesaurus']})

  " unicode search
  call dein#add('chrisbra/unicode.vim',
        \{'on_cmd': ['Digraphs',
        \            'UnicodeSearch',
        \            'UnicodeName',
        \            'UnicodeTable',
        \            'DownloadUnicode']})

  call dein#add('fmoralesc/vim-pad')

  " improve cpp etc highlighting using information from lsp
  call dein#add('jackguo380/vim-lsp-cxx-highlight',
        \{'on_ft': [
        \ 'c',
        \ 'cpp',
        \ 'objc',
        \ 'objcpp',
        \ 'cc',
        \]})

  " Alternative files
  call dein#add('tpope/vim-projectionist')

  " Open vimux pane below vim
  call dein#add('benmills/vimux')

  " Support for tmux golang
  call dein#add('sebdah/vim-delve',
        \{'on_ft': ['go']})

  " Support full testing
  call dein#add('vim-test/vim-test',
        \{'on_cmd': [
        \'TestNearest',
        \'TestSuite',
        \'TestFile',
        \'TestLast',
        \'TestVisit',
        \]})

  " javascript and typescript libraries
  call dein#add('othree/javascript-libraries-syntax.vim',
        \{'on_ft': ['javascript', 'typescript']})

  " add graphql support for libraries (TODO(@jakob): add reasonML ft)
  call dein#add('jparise/vim-graphql',
        \{'on_ft': ['graphql', 'javascript', 'typescript']})

  call dein#add('tpope/vim-dispatch',
        \{'on_cmd': ['Make', 'Dispatch']})

  call dein#end()
  call dein#save_state()
endif
" }}}

" Syntax enable
filetype plugin indent on
syntax enable

" Load General bindings
source <sfile>:h/bindings.vim

" Load Scroll config
source <sfile>:h/scrolling.vim

" Load visualisation
source <sfile>:h/visualisation.vim

" Load searching
source <sfile>:h/searching.vim

" Load misceleneous
source <sfile>:h/misc.vim

" Load abbreviation
source <sfile>:h/abbrev.vim

" Security
set secure
