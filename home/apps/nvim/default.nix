{pkgs, ...}: let
  gruvbox-material-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "gruvbox-material.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "f4z3r";
      repo = "gruvbox-material.nvim";
      rev = "v0.1.3";
      sha256 = "sha256-9TGx60Lk8k68pVEsRZJ4GYF2R1ZseJ26UwvAn8FvYBo=";
    };
  };

  cmp-luasnip-choice = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-luasnip-choice";
    src = pkgs.fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "cmp-luasnip-choice";
      rev = "4f49232e51c9df379b9daf43f25f7ee6320450f0";
      sha256 = "sha256-/s1p/WLfrHZHX6fU1p2PUQ0GIocAB4mvhjZ0XUMzkaw=";
    };
  };

  neorg-templates = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-templates";
    src = pkgs.fetchFromGitHub {
      owner = "pysan3";
      repo = "neorg-templates";
      rev = "v2.0.3";
      sha256 = "sha256-nZOAxXSHTUDBpUBS/Esq5HHwEaTB01dI7x5CQFB3pcw=";
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

  lua-packages = luaPkgs:
    with luaPkgs; let
      pathlib-nvim = buildLuarocksPackage {
        pname = "pathlib.nvim";
        version = "2.2.0-1";
        knownRockspec =
          (pkgs.fetchurl {
            url = "mirror://luarocks/pathlib.nvim-2.2.0-1.rockspec";
            sha256 = "0zj3psdq06822y8vl117z3y7zlc6jxwqppbv9irgwzr60wdz517n";
          })
          .outPath;
        src = pkgs.fetchzip {
          url = "https://github.com/pysan3/pathlib.nvim/archive/v2.2.0.zip";
          sha256 = "1nyl3y0z2rrr35dyk2ypv8xjx43zamqxlpdq468iyyhfvkplz9yw";
        };

        disabled = luaOlder "5.1";
        propagatedBuildInputs = [lua nvim-nio];

        meta = {
          homepage = "https://pysan3.github.io/pathlib.nvim/";
          description = "OS Independent, ultimate solution to path handling in neovim.";
          license.fullName = "MPL-2.0";
        };
      };
    in [pathlib-nvim];
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = false;

    extraLuaPackages = luaPkgs:
      with luaPkgs;
        (lua-packages luaPkgs)
        ++ [
          nvim-nio
          lua-utils-nvim
          plenary-nvim
          nui-nvim
        ];

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
        plugin = nvim-treesitter.withPlugins (p:
          [p.tree-sitter-lua]
          ++ nvim-treesitter.allGrammars
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
        plugin = true-zen-nvim;
        config = builtins.readFile ./plugin/true-zen.lua;
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
      {
        type = "lua";
        plugin = cmp-luasnip-choice;
        config = "require('cmp_luasnip_choice').setup()";
      }
      cmp-path
      cmp-buffer
      cmp-cmdline
      cmp-cmdline-history
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

      # neorg
      {
        type = "lua";
        plugin = neorg;
        config = builtins.readFile ./plugin/neorg.lua;
      }
      neorg-telescope
      neorg-templates

      # TODO: delete these soon
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
  home.file.".config/nvim/templates" = {
    source = ./templates;
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
