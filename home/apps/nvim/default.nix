{pkgs, ...}: let
  gruvbox-material-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "gruvbox-material.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "f4z3r";
      repo = "gruvbox-material.nvim";
      rev = "v1.7.0";
      sha256 = "sha256-VLOTOCWAruIvAB0GLaAFyy9tm0xGmE4x+Nc+as/HmeQ=";
    };
  };

  # NOTE: remove when new version for enable() released
  image-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "image.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "3rd";
      repo = "image.nvim";
      rev = "4c51d6202628b3b51e368152c053c3fb5c5f76f2";
      sha256 = "sha256-r3s19L0NcUfNTR1SQ98z8fEvhTxGRr4/jlicmbzmQZs=";
    };
    nvimSkipModules = [
      "minimal-setup"
    ];
  };

  # NOTE: remove when released to nixpkgs
  headlines-nvim-f4z3r = pkgs.vimUtils.buildVimPlugin {
    name = "headlines.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "headlines.nvim";
      rev = "bf17c96a836ea27c0a7a2650ba385a7783ed322e";
      sha256 = "sha256-LWYYVnLZgw6DhO/n0rclQVnon5TvyQVUGb2smaBzcPg=";
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
    propagatedBuildInputs = with pkgs.luajitPackages; [luasnip neorg];
  };

  markit = pkgs.vimUtils.buildVimPlugin {
    name = "markit";
    src = pkgs.fetchFromGitHub {
      owner = "2KAbhishek";
      repo = "markit.nvim";
      rev = "9b031afab214aa6e6467f275f55640989f438925";
      sha256 = "sha256-LCvACs8hHxquwBcCthfrdWQAQd8jrOwhsuZAkjqCZSQ=";
    };
    nvimSkipModules = [
      "markit"
      "markit.bookmark"
    ];
  };

  feed-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "feed-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "neo451";
      repo = "feed.nvim";
      rev = "b89f1f1d2cf85a59cfca58a87a0535e3fa7d6dfc";
      sha256 = "sha256-bTTHKA6aYpwltIvBkoQ8l9OigyrEH7Kn1eeH3nwxNuM=";
    };
    nvimSkipModules = [
      "minimal"
      "feed.pandoc.gfm"
      "feed.pickers.fzf-lua"
      "feed.pickers.mini.pick"
      "feed.pickers.telescope"
    ];
  };

  d2 = pkgs.vimUtils.buildVimPlugin {
    name = "d2";
    src = pkgs.fetchFromGitHub {
      owner = "terrastruct";
      repo = "d2-vim";
      rev = "981c87dccb63df2887cc41b96e84bf550f736c57";
      sha256 = "sha256-+mT4pEbtq7f9ZXhOop3Jnjr7ulxU32VtahffIwQqYF4=";
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
      coop-nvim = buildLuarocksPackage {
        pname = "coop.nvim";
        version = "1.1.1-0";
        knownRockspec =
          (pkgs.fetchurl {
            url = "mirror://luarocks/coop.nvim-1.1.1-0.rockspec";
            sha256 = "1w99sj02bfa02i0ivhm40md460kvlsw5a2phfln6xgxacygk64ga";
          }).outPath;
        src = pkgs.fetchFromGitHub {
          owner = "gregorias";
          repo = "coop.nvim";
          rev = "d98b9c285f28aded2db05a0c178ab0c43b3ac611";
          hash = "sha256-KcN9znmzfYoCWjV9vMya7zee9gAjxNnJ9ewfQKtspAQ=";
        };

        disabled = luaOlder "5.1";

        meta = {
          homepage = "https://github.com/gregorias/coop.nvim";
          description = "A Neovim plugin for structured concurrency with coroutines.";
          license.fullName = "GPL-3.0";
        };
      };
    in [pathlib-nvim coop-nvim];
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
          magick
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
      marksman
      rust-analyzer
      rustfmt
      terraform-ls
      nil
      harper

      universal-ctags

      clippy

      stylua

      yamlfmt

      libxml2

      tfsec

      fzf

      html-tidy

      tinymist
      typstyle
    ];

    plugins = with pkgs.vimPlugins; [
      # startup stuff
      {
        type = "lua";
        plugin = alpha-nvim;
        config = builtins.readFile ./plugin/alpha.lua;
      }

      # syntax highlighting
      plantuml-syntax
      vim-just
      d2
      rainbow-delimiters-nvim
      nvim-treesitter-endwise
      nvim-treesitter-textobjects
      {
        type = "lua";
        plugin = nvim-treesitter.withAllGrammars;
        config = builtins.readFile ./plugin/treesitter.lua;
      }
      {
        type = "lua";
        plugin = gruvbox-material-nvim;
        config = builtins.readFile ./plugin/gruvbox.lua;
      }
      {
        type = "lua";
        plugin = tint-nvim;
        config = builtins.readFile ./plugin/tint.lua;
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
        plugin = zen-mode-nvim;
        config = builtins.readFile ./plugin/zen-mode.lua;
      }

      # git integration
      {
        type = "lua";
        plugin = gitsigns-nvim;
        config = builtins.readFile ./plugin/gitsigns.lua;
      }

      # rss feed reader
      snacks-nvim
      {
        type = "lua";
        plugin = feed-nvim;
        config = builtins.readFile ./plugin/feed-nvim.lua;
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

      # http
      # {
      #   type = "lua";
      #   plugin = kulala-nvim;
      #   config = builtins.readFile ./plugin/kulala.lua;
      # }

      # completion
      friendly-snippets
      {
        type = "lua";
        plugin = luasnip;
        config = builtins.readFile ./plugin/luasnip.lua;
      }
      lspkind-nvim
      blink-emoji-nvim
      blink-nerdfont-nvim
      {
        type = "lua";
        plugin = colorful-menu-nvim;
        config = ''require('colorful-menu').setup({})'';
      }
      {
        type = "lua";
        plugin = blink-cmp;
        config = builtins.readFile ./plugin/blink.lua;
      }
      {
        type = "lua";
        plugin = neogen;
        config = ''require('neogen').setup({ snippet_engine = "luasnip" })'';
      }
      {
        type = "lua";
        plugin = tabout-nvim;
        config = builtins.readFile ./plugin/tabout.lua;
      }

      # finder
      {
        type = "lua";
        plugin = telescope-nvim;
        config = builtins.readFile ./plugin/telescope.lua;
      }
      fzfWrapper
      telescope-fzf-native-nvim
      {
        type = "lua";
        plugin = harpoon2;
        config = builtins.readFile ./plugin/harpoon.lua;
      }

      # useful stuff
      {
        type = "lua";
        plugin = flash-nvim;
        config = builtins.readFile ./plugin/flash.lua;
      }
      {
        type = "lua";
        plugin = nvim-spider;
        config = builtins.readFile ./plugin/spider.lua;
      }
      vim-repeat
      vim-surround
      targets-vim
      {
        type = "lua";
        plugin = nvim-autopairs;
        config = ''
          require('nvim-autopairs').setup({
            check_ts = true,
            ts_config = {},
          })
        '';
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

      # marks
      {
        type = "lua";
        plugin = markit;
        config = builtins.readFile ./plugin/markit.lua;
      }

      # neorg
      {
        type = "lua";
        plugin = neorg;
        config = builtins.readFile ./plugin/neorg.lua;
      }
      neorg-telescope
      neorg-templates
      {
        type = "lua";
        plugin = headlines-nvim-f4z3r;
        config = builtins.readFile ./plugin/headlines.lua;
      }
      {
        type = "lua";
        plugin = image-nvim;
        config = builtins.readFile ./plugin/image.lua;
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
        plugin = treesj;
        config = builtins.readFile ./plugin/treesj.lua;
      }

      # status line
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
      {
        type = "lua";
        plugin = nvim-navic;
        config = ''require("nvim-navic").setup({highlight=true})'';
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
