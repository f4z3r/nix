{pkgs, ...}: let
  gruvbox-material-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "gruvbox-material.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "f4z3r";
      repo = "gruvbox-material.nvim";
      rev = "v0.1.1";
      sha256 = "sha256-5r3CreexySh4sXjFlLIQb6Sy5NHbVwKVi8MXdjsl4HQ=";
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
      owner = "nvim-orgmode";
      repo = "org-bullets.nvim";
      rev = "3623e86e0fa6d07f45042f7207fc333c014bf167";
      sha256 = "sha256-aIEe1dgUmDzu9kl33JCNcgyfp8DymURltH0HcZfph0Y=";
    };
  };

  mini-align = pkgs.vimUtils.buildVimPlugin {
    name = "mini.align";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.align";
      rev = "f845218c5fea89e49074e48270dc5e1b9511a0f9";
      sha256 = "sha256-vq8l6ff3xbdYAdoyZA7VszP7Hl5oVeQCM7n89sxs+Yo=";
    };
  };

  mini-splitjoin = pkgs.vimUtils.buildVimPlugin {
    name = "mini.splitjoin";
    src = pkgs.fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.splitjoin";
      rev = "a6b043b4afb075058a8c49325ff22e07f0e96170";
      sha256 = "sha256-u4eDN8b7CZrfrtUILR/W6Q36JCLtPE2mrOc5uouzmDY=";
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
      deadnix
      statix
      alejandra

      cbfmt

      shfmt
      shellharden

      gofumpt
      goimports-reviser
      revive

      gopls
      yaml-language-server
      helm-ls
      ruff-lsp
      nodePackages.bash-language-server
      marksman
      rust-analyzer
      terraform-ls
      nil

      universal-ctags

      clippy

      stylua

      yamlfmt

      tfsec

      fzf
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
          nvim-treesitter.allGrammars
          ++ [
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
      harpoon2

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
  home.file.".config/nvim/after" = {
    source = ./after;
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
