{
  pkgs,
  pkgs-stable,
  pkgs-custom,
  ...
}: let
  gruvbox-material-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "gruvbox-material.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "f4z3r";
      repo = "gruvbox-material.nvim";
      rev = "v1.8.1";
      sha256 = "sha256-nNBV66GHG3Km92aWhFeo3HgjWQNdMQpIl4Kq08rEmPs=";
    };
  };

  executor-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "executor.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "f4z3r";
      repo = "executor.nvim";
      rev = "feat/set-command";
      sha256 = "sha256-+L8ucPRi3W4BZCDKifkfba6lp1S/pZ5rs8giZjBQpic=";
    };
    nvimSkipModules = [
      "executor"
      "executor.executor"
    ];
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
    dependencies = [
      pkgs.vimPlugins.neorg
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

  oil-git-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "oil-git.nvim";
    src = pkgs.fetchFromGitHub {
      # FIX(@f4z3r): wait for PR to be merged: https://github.com/benomahony/oil-git.nvim/pull/10
      # owner = "benomahony";
      owner = "LeonWiese";
      repo = "oil-git.nvim";
      rev = "6fa5df51824d9e9aa1b53ad60de997fd288fd849";
      sha256 = "sha256-X3VaXEkE40xUb09LWlY5JdzMjKa6H31ZybeTO6Pn6Ro=";
    };
    dependencies = [
      pkgs.vimPlugins.oil-nvim
    ];
  };

  oil-lsp-diagnostics-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "oil-lsp-diagnostics.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "JezerM";
      repo = "oil-lsp-diagnostics.nvim";
      rev = "e04e3c387262b958fee75382f8ff66eae9d037f4";
      sha256 = "sha256-E8jukH3I8XDdgrG4XHCo9AuFbY0sLX24pjk054xmB9E=";
    };
    dependencies = [
      pkgs.vimPlugins.oil-nvim
    ];
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
          dkjson
        ];

    initLua = ''

      require("bindings")
      require("visualisation")
      require("searching")
      require("scrolling")
      require("filetypes")
      require("misc")
    '';
    extraPackages = with pkgs; [
      inotify-tools

      deadnix
      statix
      alejandra
      nil

      cbfmt

      shfmt
      shellharden

      gofumpt
      goimports-reviser
      revive
      gopls

      beancount-language-server

      yaml-language-server
      yamlfmt

      helm-ls

      marksman

      ty

      rust-analyzer
      rustfmt

      terraform-ls
      tfsec

      harper
      prettier

      clippy

      stylua

      libxml2

      html-tidy

      tinymist
      typstyle
    ];

    plugins = with pkgs.vimPlugins; [
      # syntax highlighting
      plantuml-syntax
      vim-just
      d2
      rainbow-delimiters-nvim
      nvim-treesitter-endwise
      # TODO: f4z3r - add way to re-add this
      # {
      #   type = "lua";
      #   plugin = nvim-treesitter-textsubjects;
      #   config = builtins.readFile ./plugin/textsubjects.lua;
      # }
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
        plugin = outline-nvim;
        config = builtins.readFile ./plugin/outline.lua;
      }
      {
        type = "lua";
        plugin = zen-mode-nvim;
        config = builtins.readFile ./plugin/zen-mode.lua;
      }
      {
        type = "lua";
        plugin = visual-whitespace-nvim;
        config = "require('visual-whitespace').setup({})";
      }

      # git integration
      {
        type = "lua";
        plugin = gitsigns-nvim;
        config = builtins.readFile ./plugin/gitsigns.lua;
      }
      {
        type = "lua";
        plugin = diffview-nvim;
        config = builtins.readFile ./plugin/diffview.lua;
      }
      {
        type = "lua";
        plugin = gitlinker-nvim;
        config = builtins.readFile ./plugin/gitlinker.lua;
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

      # http
      # {
      #   type = "lua";
      #   plugin = kulala-nvim;
      #   config = builtins.readFile ./plugin/kulala.lua;
      # }

      # sessions
      {
        type = "lua";
        plugin = resession-nvim;
        config = builtins.readFile ./plugin/resession.lua;
      }

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
        plugin = snacks-nvim;
      }
      {
        type = "lua";
        plugin = opencode-nvim;
      }
      {
        type = "lua";
        plugin = neogen;
        config = ''require('neogen').setup({ snippet_engine = "luasnip" })'';
      }

      # finder
      {
        type = "lua";
        plugin = tv-nvim;
        config = builtins.readFile ./plugin/tv.lua;
      }
      {
        type = "lua";
        plugin = grapple-nvim;
        config = builtins.readFile ./plugin/grapple.lua;
      }
      {
        type = "lua";
        plugin = marks-nvim;
        config = builtins.readFile ./plugin/marks.lua;
      }

      # runner
      {
        type = "lua";
        plugin = executor-nvim;
        config = builtins.readFile ./plugin/executor.lua;
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

      # oil
      nui-nvim
      plenary-nvim
      nvim-web-devicons
      {
        type = "lua";
        plugin = oil-nvim;
        config = builtins.readFile ./plugin/oil.lua;
      }
      {
        type = "lua";
        plugin = oil-git-nvim;
        config = builtins.readFile ./plugin/oil-git.lua;
      }
      {
        type = "lua";
        plugin = oil-lsp-diagnostics-nvim;
        config = builtins.readFile ./plugin/oil-lsp.lua;
      }

      # neorg
      {
        type = "lua";
        plugin = neorg;
        config = builtins.readFile ./plugin/neorg.lua;
      }
      neorg-templates
      {
        type = "lua";
        plugin = headlines-nvim;
        config = builtins.readFile ./plugin/headlines.lua;
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
      {
        type = "lua";
        plugin = todo-comments-nvim;
        config = builtins.readFile ./plugin/todo-comments.lua;
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
