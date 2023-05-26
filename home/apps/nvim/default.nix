{ pkgs, ... }:

let
  gruvbox-material-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "gruvbox-material.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "f4z3r";
      repo = "gruvbox-material.nvim";
      rev = "e128092aa0ebfd71fc49a09e3e1729f8a60a033e";
      sha256 = "sha256-WeEWc+Ja4AfLxMsxQ2yHofBK48UWF3AOik0YIuC+cFk=";
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
        shellcheck
        nodePackages.bash-language-server
        universal-ctags
        marksman
        rust-analyzer
        lua-language-server
        rnix-lsp
        fzf
      ];

      plugins = with pkgs.vimPlugins; [
        # startup stuff
        vim-startify

        # syntax highlighting
        nvim-ts-rainbow2
        nvim-treesitter-textobjects
        {
          type = "lua";
          plugin = (nvim-treesitter.withPlugins (p: with p; [
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
          ]));
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

        # useful stuff
        {
          type = "lua";
          plugin = vim-easymotion;
          config = builtins.readFile ./plugin/vim-easymotion.lua;
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
          config = builtins.readFile ./plugin/autopairs.lua;
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

        # executor TODO (dispatch, vimux, etc)
        # vim-projectionist
        # vimux
        # vim-dispatch

        # searching
        incsearch-vim
        incsearch-easymotion-vim

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
          config = builtins.readFile ./plugin/comment.lua;
        }

        # alignment
        {
          type = "lua";
          plugin = vim-easy-align;
          config = builtins.readFile ./plugin/vim-easy-align.lua;
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
  }
