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

  # temporary override to sidestep subprocess issue
  neotest = pkgs.vimUtils.buildVimPlugin {
    name = "neotest";
    src = pkgs.fetchFromGitHub {
      owner = "f4z3r";
      repo = "neotest";
      rev = "310c1ed801fc6716512bf503c2e06f2d927b3cd1";
      sha256 = "sha256-x4YPyf9626N9M4lSVgyrc2/OT0XlwTpbpRydqVwmstg=";
    };
  };

  overseer-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "overseer.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "stevearc";
      repo = "overseer.nvim";
      rev = "d286e681c4efa7477fccb113e23ef645fcb43cac";
      sha256 = "sha256-blWHi+fWUGi3+HMk+ejfgzcZnCthaYDMGVDrkJbnEMs=";
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

  align-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "align.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Vonr";
      repo = "align.nvim";
      rev = "2004d263bb1b1ec28e55cf56c35944ec4ea23f8b";
      sha256 = "sha256-FqexLsG6PAslo2XeVLpFfThtNCrvwcytOEAaQcnJ/PQ=";
    };
  };

  yanky = pkgs.vimUtils.buildVimPlugin {
    name = "yanky.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "gbprod";
      repo = "yanky.nvim";
      rev = "16884855e65931cdec3937d60bfb942530535e9c";
      sha256 = "sha256-R0s5FvCj3dPJieBUMbCYoO9HP6pGbJXPgeoglQh8nf0=";
    };
  };
in
  {
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
        require("misc")
      '';
      extraPython3Packages = ps: with ps; [
      ];
      extraPackages = with pkgs; [
        zig
        deadnix
        statix
        nixfmt
        hadolint
        shfmt
        shellcheck
        shellharden
        gopls
        revive
        nodePackages.bash-language-server
        universal-ctags
        marksman
        rustfmt
        rust-analyzer
        clippy
        lua-language-server
        stylua
        rnix-lsp
        yamlfmt
        fzf
      ];

      plugins = with pkgs.vimPlugins; [
        # startup stuff
        {
          type = "lua";
          plugin = dashboard-nvim;
          config = builtins.readFile ./plugin/dashboard.lua;
        }

        # syntax highlighting
        nvim-ts-rainbow2
        nvim-treesitter-textobjects
        {
          type = "lua";
          plugin = nvim-treesitter.withPlugins (p: with p; [
            org
            query
            bash
            markdown
            markdown_inline
            python
            perl
            go
            rust
            ruby
            regex
            lua
            vim
            nix
            toml
            yaml
            json
            jsonc
            json5
            hjson
            hcl
            html
            sql
            gitignore
            gitcommit
            git_config
            git_rebase
            gitattributes
            c
            cpp
            dockerfile
            make
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
          plugin = dressing-nvim;
          config = builtins.readFile ./plugin/dressing.lua;
        }
        {
          type = "lua";
          plugin = symbols-outline-nvim;
          config = builtins.readFile ./plugin/symbols-outline.lua;
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
          plugin = neodev-nvim;
          config = builtins.readFile ./plugin/neodev.lua;
        }
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
          plugin = null-ls-nvim;
          config = builtins.readFile ./plugin/null-ls.lua;
        }
        {
          type = "lua";
          plugin = nvim-dap;
          config = builtins.readFile ./plugin/dap.lua;
        }
        {
          type = "lua";
          plugin = nvim-dap-ui;
          config = ''require('dapui').setup()'';
        }
        {
          type = "lua";
          plugin = rust-tools-nvim;
          config = builtins.readFile ./plugin/rust-tools.lua;
        }
        {
          type = "lua";
          plugin = nvim-dap-python;
          config = ''require('dap-python').setup()'';
        }
        {
          type = "lua";
          plugin = nvim-dap-go;
          config = ''require('dap-go').setup()'';
        }

        # test and runner stuff
        {
          type = "lua";
          plugin = overseer-nvim;
          config = builtins.readFile ./plugin/overseer.lua;
        }
        neotest-go
        neotest-python
        neotest-rust
        {
          type = "lua";
          plugin = neotest;
          config = builtins.readFile ./plugin/neotest.lua;
        }

        # completion
        luasnip
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
          plugin = hop-nvim;
          config = builtins.readFile ./plugin/hop.lua;
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
          config = ''require('nvim-autopairs').setup()'';
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

        # comments
        {
          type = "lua";
          plugin = comment-nvim;
          config = ''require('Comment').setup()'';
        }

        # yanks
        # {
        #   type = "lua";
        #   plugin = yanky;
        #   config = builtins.readFile ./plugin/yanky.lua;
        # }

        # alignment
        {
          type = "lua";
          plugin = align-nvim;
          config = builtins.readFile ./plugin/align.lua;
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

    home.file.".config/nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    home.file.".config/nvim/ftplugin" = {
      source = ./ftplugin;
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
