{ pkgs, ... }:

let
  telescope-orgmode = pkgs.vimUtils.buildVimPlugin {
    name = "telescope-orgmode.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "joaomsa";
      repo = "telescope-orgmode.nvim";
      rev = "eabff061c3852a9aa94e672a7d2fa4a1ef63f9e2";
      sha256 = "sha256-/sW4vfBbyurAQBgO0guU8BALB/KN9LYwhMBG8+EEuQo=";
    };
  };

  org-bullets = pkgs.vimUtils.buildVimPlugin {
    name = "org-bullets.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "org-bullets.nvim";
      rev = "6e0d60e901bb939eb526139cb1f8d59065132fd9";
      sha256 = "sha256-x6S4WdgfUr7HGEHToSDy3pSHEwOPQalzWhBUipqMtnw=";
    };
  };

  fern-renderer-nerdfont-vim = pkgs.vimUtils.buildVimPlugin {
    name = "fern-renderer-nerdfont-vim";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-renderer-nerdfont.vim";
      rev = "1e90a78ab5510fbcedc85abeb9a251d978726935";
      sha256 = "sha256-foX/RguLMKVs0TvBcnfH9m3hkDQmfokzuESrb4iUmw8=";
    };
  };

  nerdfont-vim = pkgs.vimUtils.buildVimPlugin {
    name = "nerdfont-vim";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "nerdfont.vim";
      rev = "3daf10116daad5da257486c9043c658cced4dd31";
      sha256 = "sha256-FKjjuPk8aQaAB+Jlwa3X8SByFd4WIsthDoqAnX+EJP0=";
    };
  };

  fern-git-status = pkgs.vimUtils.buildVimPlugin {
    name = "fern-git-status";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-git-status.vim";
      rev = "151336335d3b6975153dad77e60049ca7111da8e";
      sha256 = "sha256-9N+T/MB+4hKcxoKRwY8F7iwmTsMtNmHCHiVZfcsADcc=";
    };
  };
in
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
      {
        plugin = fern-vim;
        config = builtins.readFile ./plugin/fern.vim;
      }
      fern-renderer-nerdfont-vim
      nerdfont-vim
      fern-git-status
      vim-repeat
      gruvbox-material
      nerdcommenter
      {
        plugin = orgmode;
        config = builtins.readFile ./plugin/orgmode.vim;
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [ p.org p.query ]));
        config = builtins.readFile ./plugin/treesitter.vim;
      }
      {
        plugin = org-bullets;
        config = builtins.readFile ./plugin/org-bullets.vim;
      }
      telescope-orgmode
      vim-fugitive
      {
        plugin = telescope-nvim;
        config = builtins.readFile ./plugin/telescope.vim;
      }
      telescope-coc-nvim
      fzfWrapper
      telescope-fzf-native-nvim
      vim-surround
      {
        plugin = indentLine;
        config = builtins.readFile ./plugin/indentLine.vim;
      }
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
      bullets-vim
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
      coc-pairs
      coc-docker
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
      settings = {
        "diagnostic.errorSign" = "";
        "diagnostic.warningSign" = "";
        "diagnostic.infoSign" = "כֿ";
        "diagnostic.hintSign" = "";
        "diagnostic.displayByAle" = true;
        "yank.limit" = 5;
        "python.linting.ruffEnabled" = true;
        "pyright.testing.provider" = "pytest";
        "codeLens.enable" = true;
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
          "default" = "v";
        };
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
    };
  };

  home.file.".config/nvim/ftplugin" = {
    source = ./ftplugin;
    recursive = true;
  };
  home.file.".config/nvim/after" = {
    source = ./after;
    recursive = true;
  };
}
