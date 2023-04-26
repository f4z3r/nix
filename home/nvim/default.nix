{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = (
      builtins.readFile ./functions.vim +
      builtins.readFile ./bindings.vim +
      builtins.readFile ./visualisation.vim +
      builtins.readFile ./searching.vim +
      builtins.readFile ./scrolling.vim +
      builtins.readFile ./misc.vim +
      builtins.readFile ./abbrev.vim +
      builtins.readFile ./plugin/grep-operator.vim
      );
    extraPackages = with pkgs; [
      fzf
    ];

    plugins = with pkgs.vimPlugins; [
      vim-startify
      vim-snippets
      vim-devicons
      {
        plugin = ale;
        config = builtins.readFile ./plugin/ale.vim;
      }
      fern-vim
      vim-repeat
      gruvbox-material
      nerdcommenter
      vim-fugitive
      {
        plugin = telescope-nvim;
        config = builtins.readFile ./plugin/telescope.vim;
      }
      telescope-coc-nvim
      telescope-fzf-native-nvim
      vim-surround
      {
        plugin = indentLine;
        config = builtins.readFile ./plugin/indentLine.vim;
      }
      todo-txt-vim
      {
        plugin = vim-easy-align;
        config = builtins.readFile ./plugin/vim-easy-align.vim;
      }
      {
        plugin = vim-polyglot;
        config = builtins.readFile ./plugin/polyglot.vim;
      }
      jsonc-vim
      {
        plugin = rainbow;
        config = builtins.readFile ./plugin/rainbow.vim;
      }
      targets-vim
      vim-indent-object
      vim-signature
      vim-gitgutter
      incsearch-vim
      incsearch-easymotion-vim
      {
        plugin = vim-easymotion;
        config = builtins.readFile ./plugin/vim-easymotion.vim;
      }
      vim-gutentags
      tagbar
      {
        plugin = splitjoin-vim;
        config = builtins.readFile ./plugin/splitjoin.vim;
      }
      vim-abolish
      vim-endwise
      {
        plugin = vim-airline;
        config = builtins.readFile ./plugin/vim-airline.vim;
      }
      camelcasemotion
      vim-projectionist
      vimux
      {
        plugin = vim-test;
        config = builtins.readFile ./plugin/vim-test.vim;
      }
      vim-dispatch
      coc-yank
      coc-go
      coc-sh
      coc-toml
      coc-lua
      coc-snippets
      coc-pyright
      coc-vimlsp
      coc-rust-analyzer
    ];

    coc = {
      enable = true;
      pluginConfig = builtins.readFile ./plugin/coc.vim;
      settings = ''
      {
              "diagnostic.errorSign" = "";
              "diagnostic.warningSign" = "";
              "diagnostic.infoSign" = "כֿ";
              "diagnostic.hintSign" = "";
              "diagnostic.displayByAle" = true;
              "suggest.completionItemKindLabels" = {
                "text" = "";
                "function" = "";
                "method" = "";
                "constructor" = "";
                "field" = "羅";
                "variable" = "";
                "class" = "";
                "interface" = "";
                "module" = "";
                "property" = "";
                "unit" = "";
                "value" = "";
                "enum" = "";
                "keyword" = "";
                "snippet" = "";
                "color" = "";
                "file" = "";
                "reference" = "";
                "folder" = "";
                "enumMember" = "";
                "constant" = "";
                "struct" = "";
                "event" = "";
                "operator" = "";
                "typeParameter" = "tp";
                "default" = "v;
              }
              "python.jediEnabled" = false;
              "python.linting.enabled"  = false;
              "languageserver" = {
                "nix" = {
                  "command" = "rnix-lsp";
                  "filetypes" = [
                    "nix"
                  ];
                };
              };
            };
      '';
    };
  };

  home.file.".config/nvim/ftplugin" = {
    source = ./ftplugin;
    recursive = true;
  };
}
