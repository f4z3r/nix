{ pkgs, ... }:

let
  gruvbox-material-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "gruvbox-material.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "WIttyJudge";
      repo = "gruvbox-material.nvim";
      rev = "ae3d4c9c7fd4c4eb4121df3068cfa77f969aec92";
      sha256 = "sha256-WeEWc+Ja4AfLxMsxQ2yHofBK48UWF3AOik0YIuC+cFk=";
    };
  };

  plantuml-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "plantuml-nvim";
    src = pkgs.fetchurl {
      url =
        "https://gitlab.com/itaranto/plantuml.nvim/-/archive/master/plantuml.nvim-master.tar.gz";
      sha256 = "sha256-wRoc+j/LJaYaCinju0XeVICaTc1O+hdNiqcjut+6Z1c=";
    };
  };

  maximize-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "maximize.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "declancm";
      repo = "maximize.nvim";
      rev = "97bfc171775c404396f8248776347ebe64474fe7";
      sha256 = "sha256-k8Cqti4nLUvtl0EBaU8ZPYJ6JlfnRlN6nCxE/WHrbnw=";
    };
  };

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

  mini-align = pkgs.vimUtils.buildVimPlugin {
    name = "mini.align";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.align";
      rev = "c5ab28809c630b65ffe069b564ce1d473bbcb332";
      sha256 = "sha256-PVSgN0VamkR6PfpNOfkSv6LiIVwIlWWYfySxp1P+LAE=";
    };
  };

  mini-splitjoin = pkgs.vimUtils.buildVimPlugin {
    name = "mini.splitjoin";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.splitjoin";
      rev = "2b4ade24c1d46ce98801b74fc84241d7b676f9f4";
      sha256 = "sha256-/4yqAnnTzrQ1jbhMGIk/wKz7QbqSZRmhgBLAWgugYOQ=";
    };
  };

  nvim-table-md = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-table-md";
    src = pkgs.fetchFromGitHub {
      owner = "allen-mack";
      repo = "nvim-table-md";
      rev = "77bf0afc093ffc8b7336c1096a844e76b09e9d04";
      sha256 = "sha256-Q+RLKClM1F+VCdv72st0DhAFQzOyvBwIwguplSkRqSI=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = false;

    extraLuaConfig = ''

      require("bindings")
      require("visualisation")
      require("searching")
      require("scrolling")
      require("filetypes")
      require("misc")
    '';
    extraPackages = with pkgs; [
      zig
      deadnix
      statix
      nixfmt
      # hadolint
      shfmt
      shellcheck
      shellharden
      gopls
      revive
      yaml-language-server
      helm-ls
      ruff-lsp
      nodePackages.bash-language-server
      universal-ctags
      marksman
      rustfmt
      rust-analyzer
      clippy
      stylua
      yamlfmt
      nil
      fzf
      terraform-ls
      tfsec
      plantuml
    ];

    plugins = with pkgs.vimPlugins; [
      # startup stuff
      {
        type = "lua";
        plugin = alpha-nvim;
        config = builtins.readFile ./plugin/alpha.lua;
      }

      # syntax highlighting
      vim-just
      rainbow-delimiters-nvim
      nvim-treesitter-textobjects
      {
        type = "lua";
        plugin = nvim-treesitter-context;
        config = builtins.readFile ./plugin/treesitter-context.lua;
      }
      {
        type = "lua";
        plugin = nvim-treesitter.withPlugins (_:
          nvim-treesitter.allGrammars ++ [
            (pkgs.tree-sitter.buildGrammar {
              language = "gotmpl";
              version = "master";
              src = pkgs.fetchFromGitHub {
                owner = "ngalaiko";
                repo = "tree-sitter-go-template";
                rev = "17144a77be0acdecebd9d557398883569fed41de";
                sha256 = "sha256-aB8MTTKzxV9+66goNfFRI39wzuBiGECAc8HvAQzIv80=";
              };
            })
          ]);
        config = builtins.readFile ./plugin/treesitter.lua;
      }
      {
        type = "lua";
        plugin = gruvbox-material-nvim;
        config = builtins.readFile ./plugin/gruvbox.lua;
      }
      {
        type = "lua";
        plugin = indent-blankline-nvim;
        config = builtins.readFile ./plugin/indent-blankline.lua;
      }
      {
        type = "lua";
        plugin = vim-illuminate;
        config = builtins.readFile ./plugin/illuminate.lua;
      }
      {
        type = "lua";
        plugin = dressing-nvim;
        config = builtins.readFile ./plugin/dressing.lua;
      }
      {
        type = "lua";
        plugin = symbols-outline-nvim;
        config = builtins.readFile ./plugin/symbols-outline.lua;
      }
      {
        type = "lua";
        plugin = twilight-nvim;
        config = builtins.readFile ./plugin/twilight.lua;
      }

      # git integration
      {
        type = "lua";
        plugin = gitsigns-nvim;
        config = builtins.readFile ./plugin/gitsigns.lua;
      }

      # lsp stuff
      {
        type = "lua";
        plugin = nvim-lspconfig;
        config = builtins.readFile ./plugin/lsp.lua;
      }
      {
        type = "lua";
        plugin = trouble-nvim;
        config = builtins.readFile ./plugin/trouble.lua;
      }
      {
        type = "lua";
        plugin = none-ls-nvim;
        config = builtins.readFile ./plugin/none-ls.lua;
      }
      {
        type = "lua";
        plugin = refactoring-nvim;
        config = "require('refactoring').setup()";
      }
      # {
      #   type = "lua";
      #   plugin = nvim-dap;
      #   config = builtins.readFile ./plugin/dap.lua;
      # }
      # {
      #   type = "lua";
      #   plugin = nvim-dap-ui;
      #   config = "require('dapui').setup()";
      # }
      # {
      #   type = "lua";
      #   plugin = rust-tools-nvim;
      #   config = builtins.readFile ./plugin/rust-tools.lua;
      # }
      # {
      #   type = "lua";
      #   plugin = nvim-dap-python;
      #   config = "require('dap-python').setup()";
      # }
      # {
      #   type = "lua";
      #   plugin = nvim-dap-go;
      #   config = "require('dap-go').setup()";
      # }

      # test and runner stuff
      {
        type = "lua";
        plugin = overseer-nvim;
        config = builtins.readFile ./plugin/overseer.lua;
      }
      {
        type = "lua";
        plugin = neotest;
        config = builtins.readFile ./plugin/neotest.lua;
      }
      neotest-go
      neotest-python
      neotest-rust

      # completion
      friendly-snippets
      {
        type = "lua";
        plugin = luasnip;
        config = builtins.readFile ./plugin/luasnip.lua;
      }
      lspkind-nvim
      cmp-nvim-lsp-signature-help
      cmp_luasnip
      cmp-path
      cmp-buffer
      cmp-nvim-lsp
      {
        type = "lua";
        plugin = nvim-cmp;
        config = builtins.readFile ./plugin/cmp.lua;
      }

      # finder
      {
        type = "lua";
        plugin = telescope-nvim;
        config = builtins.readFile ./plugin/telescope.lua;
      }
      fzfWrapper
      telescope-fzf-native-nvim
      telescope-orgmode
      telescope-undo-nvim

      # useful stuff
      {
        type = "lua";
        plugin = flash-nvim;
        config = builtins.readFile ./plugin/flash.lua;
      }
      {
        type = "lua";
        plugin = camelcasemotion;
        config = builtins.readFile ./plugin/camelcasemotion.lua;
      }
      vim-repeat
      vim-surround
      targets-vim
      vim-signature
      {
        type = "lua";
        plugin = nvim-autopairs;
        config = ''
          require('nvim-autopairs').setup({
                      check_ts = true,
                      ts_config = {},
                    })'';
      }

      # tree
      nui-nvim
      plenary-nvim
      nvim-web-devicons
      {
        type = "lua";
        plugin = neo-tree-nvim;
        config = builtins.readFile ./plugin/neo-tree.lua;
      }

      # tag generation
      vim-gutentags

      # orgmode
      {
        type = "lua";
        plugin = orgmode;
        config = builtins.readFile ./plugin/orgmode.lua;
      }
      {
        type = "lua";
        plugin = org-bullets;
        config = builtins.readFile ./plugin/org-bullets.lua;
      }
      {
        type = "lua";
        plugin = nvim-table-md;
      }
      plantuml-syntax
      {
        type = "lua";
        plugin = plantuml-nvim;
        config = builtins.readFile ./plugin/plantuml.lua;
      }

      # comments
      {
        type = "lua";
        plugin = comment-nvim;
        config = "require('Comment').setup()";
      }

      # yanks
      {
        type = "lua";
        plugin = yanky-nvim;
        config = builtins.readFile ./plugin/yanky.lua;
      }

      # alignment
      {
        type = "lua";
        plugin = mini-align;
        config = builtins.readFile ./plugin/align.lua;
      }
      {
        type = "lua";
        plugin = mini-splitjoin;
        config = builtins.readFile ./plugin/splitjoin.lua;
      }

      # status line
      {
        type = "lua";
        plugin = maximize-nvim;
        config = builtins.readFile ./plugin/maximize.lua;
      }
      {
        type = "lua";
        plugin = lualine-nvim;
        config = builtins.readFile ./plugin/lualine.lua;
      }
      {
        type = "lua";
        plugin = nvim-notify;
        config = builtins.readFile ./plugin/notify.lua;
      }
    ];
  };

  home.file.".local/share/nvim/lua/addons" = {
    source = ./lls-addons;
    recursive = true;
  };
  home.file.".config/nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
  home.file.".config/nvim/ftplugin" = {
    source = ./ftplugin;
    recursive = true;
  };
  home.file.".config/nvim/queries" = {
    source = ./queries;
    recursive = true;
  };
  home.file.".config/nvim/spell/en.utf-8.add" = {
    source = ./spell/en.utf-8.add;
  };
  home.file.".config/nvim/spell/de.utf-8.add" = {
    source = ./spell/de.utf-8.add;
  };
  home.file.".config/nvim/spell/fr.utf-8.add" = {
    source = ./spell/fr.utf-8.add;
  };
}
