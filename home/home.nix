{ pkgs, lib, hostname, username, theme ? "dark", polybar_dpi, font_size
, scratch_res, ... }:

assert lib.asserts.assertOneOf "theme" theme [ "dark" "light" ];

let
  custom-lua-packages = luaPkgs:
    with luaPkgs;
    let
      # generated with `luarocks-nix lua-path`
      lanes = buildLuarocksPackage {
        pname = "lanes";
        version = "3.16.0-0";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/lanes-3.16.0-0.rockspec";
          sha256 = "0clnd3fsbx6w340bqddkcw0kdp4jsnnymf0mwcxdh0njkqfsxwma";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/LuaLanes/lanes.git",
            "rev": "49ef9d50d475921aab0c50b13b857f8cb990fcc0",
            "date": "2022-03-09T14:11:21+01:00",
            "path": "/nix/store/b35avrsmhz6qpz7ypy4z323x4mzi4nzv-lanes",
            "sha256": "1i3py8h1m9va4fha5j5awzpfrg830rsda1691kbmj7k15i8xi2z1",
            "fetchLFS": false,
            "fetchSubmodules": true,
            "deepClone": false,
            "leaveDotGit": false
          }
        '') [ "date" "path" ]);

        disabled = luaOlder "5.1";
        propagatedBuildInputs = [ lua ];
        externalDeps = [
          {
            name = "PTHREAD";
            dep = pkgs.glibc;
          }
        ];

        meta = {
          homepage = "https://github.com/LuaLanes/lanes";
          description = "Multithreading support for Lua";
          license.fullName = "MIT/X11";
        };
      };
      lua-path = buildLuarocksPackage {
        pname = "lua-path";
        version = "0.3.1-2";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/lua-path-0.3.1-2.rockspec";
          sha256 = "1y0r23bbqhrd3wl7f5fpm1fqijb5sar59if4cif1j789rymf43z2";
        }).outPath;
        src = pkgs.fetchzip {
          url = "https://github.com/moteus/lua-path/archive/v0.3.1.zip";
          sha256 = "1v65rsakwi1n64v3ylpsyml9dg8kac8c1glnlng0ccrqnlw6jzka";
        };

        disabled = (luaOlder "5.1") || (luaAtLeast "5.5");
        propagatedBuildInputs = [ lua ];

        meta = {
          homepage = "https://github.com/moteus/lua-path";
          description = "File system path manipulation library";
          license.fullName = "MIT/X11";
        };
      };
      lua-fun = buildLuarocksPackage {
        pname = "fun";
        version = "0.1.3-1";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/fun-0.1.3-1.rockspec";
          sha256 = "03bimwzz9qwcs759ld69bljvnaim7dlsppg4w1hgxmvm6f2c8058";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/luafun/luafun.git",
            "rev": "02960048e4dff4f5fd5b683c4b61f9df42e8339f",
            "date": "2016-01-18T10:01:48+03:00",
            "path": "/nix/store/xx98fa3m6av4fcakczlhcgglndygb5l9-luafun",
            "sha256": "16m0hg3480c03pm1mmsfrgad3l28nbwkkjqvfbrxbns3nl5y5sk8",
            "fetchLFS": false,
            "fetchSubmodules": true,
            "deepClone": false,
            "leaveDotGit": false
          }
        '') [ "date" "path" ]);

        propagatedBuildInputs = [ lua ];

        meta = {
          homepage = "https://luafun.github.io/";
          description =
            "High-performance functional programming library for Lua";
          license.fullName = "MIT/X11";
        };
      };
      date = buildLuarocksPackage {
        pname = "date";
        version = "2.2-2";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/date-2.2-2.rockspec";
          sha256 = "0z2gb4rxfrkdx3zlysmlvfpm867fk0yq0bsn7yl789pvgf591l1x";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/Tieske/date.git",
            "rev": "e5d38bb4e8b8d258d4fc07f3423aa0ac8d1deb6f",
            "date": "2021-11-22T12:57:18+01:00",
            "path": "/nix/store/dflfbxkaz1wfja0v3l9mvafz5dinvm53-date",
            "sha256": "1g50117sx2as5rf21gfddbmcsz7gv4pxs03z8a6d8dwbx31v4g2f",
            "fetchLFS": false,
            "fetchSubmodules": true,
            "deepClone": false,
            "leaveDotGit": false
          }
        '') [ "date" "path" ]);

        disabled = (luaOlder "5.0") || (luaAtLeast "5.5");
        propagatedBuildInputs = [ lua ];

        meta = {
          homepage = "https://github.com/Tieske/date";
          description = "Date & Time module for Lua 5.x";
          license.fullName = "MIT";
        };
      };
      ansicolors = buildLuarocksPackage {
        pname = "ansicolors";
        version = "1.0.2-3";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/ansicolors-1.0.2-3.rockspec";
          sha256 = "19y962xdx5ldl3596ywdl7n825dffz9al6j6rx6pbgmhb7pi8s5v";
        }).outPath;
        src = pkgs.fetchurl {
          url =
            "https://github.com/kikito/ansicolors.lua/archive/v1.0.2.tar.gz";
          sha256 = "0r4xi57njldmar9pn77l0vr5701rpmilrm51spv45lz0q9js8xps";
        };

        disabled = luaOlder "5.1";
        propagatedBuildInputs = [ lua ];

        meta = {
          homepage = "https://github.com/kikito/ansicolors.lua";
          description = "Library for color Manipulation.";
          license.fullName = "MIT <http://opensource.org/licenses/MIT>";
        };
      };
      lua-log = buildLuarocksPackage {
        pname = "lua-log";
        version = "0.1.6-1";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/lua-log-0.1.6-1.rockspec";
          sha256 = "19k2hq7w1sizdar3470jwr016gak8a0x53n3c6mpnpbqz6wjlcsc";
        }).outPath;
        src = pkgs.fetchzip {
          url = "https://github.com/moteus/lua-log/archive/v0.1.6.zip";
          sha256 = "0j24mdpsa5fzzibx1734dcg506qzz5c0mq217bxij1ciivkyy9qm";
        };

        disabled = (luaOlder "5.1") || (luaAtLeast "5.4");
        propagatedBuildInputs = [ date lua ];

        meta = {
          homepage = "https://github.com/moteus/lua-log";
          description = "Asynchronous logging library";
          license.fullName = "MIT/X11";
        };
      };
    in [ lanes lua-path lua-fun lua-log date ansicolors ];
  lua-packages = with pkgs.luajitPackages;
    [
      http
      lyaml
      lua-toml
      rapidjson
      argparse
      basexx
      busted
      compat53

      # tooling
      luacheck
      # dependencies required elsewhere
      luasec
      luasocket
      luv
      # dependencies for lua-http
      cqueues
      luaossl
      binaryheap
      lpeg
      lpeg_patterns
      fifo
    ] ++ [ (pkgs.luajit.withPackages custom-lua-packages) ];

in {
  imports = [
    (import ./apps/bspwm/default.nix { inherit pkgs hostname scratch_res; })
    (import ./apps/sxhkd/default.nix { inherit pkgs username; })
    (import ./apps/polybar/default.nix { inherit pkgs polybar_dpi; })
    ./apps/picom.nix
    ./apps/rofi/default.nix
    (import ./apps/git/default.nix { inherit pkgs theme; })
    (import ./apps/wezterm.nix { inherit pkgs theme font_size; })
    (import ./apps/tmux.nix { inherit pkgs theme; })
    (import ./apps/zsh/default.nix { inherit lib pkgs theme lua-packages; })
    ./apps/starship.nix
    ./apps/gpg.nix
    ./apps/nvim/default.nix
    ./apps/broot.nix
    (import ./apps/bat.nix { inherit pkgs theme; })
    (import ./apps/mpd/default.nix { inherit pkgs username; })
  ];

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tealdeer = {
      enable = true;
      settings = { updates = { auto_update = false; }; };
    };

    rbw = {
      enable = true;
      settings = {
        email = "jakobbeckmann@pm.me";
        pinentry = "curses";
      };
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    feh.enable = true;
    bottom.enable = true;

    exa = {
      enable = true;
      icons = true;
    };
  };

  services = {
    dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
        size = "64x64";
      };
      settings = {
        urgency_low = {
          frame_color = "#1D918B";
          foreground = "#FFEE79";
          background = "#18191E";
          timeout = 2;
        };

        urgency_normal = {
          frame_color = "#D16BB7";
          foreground = "#FFEE79";
          background = "#18191E";
          timeout = 5;
        };

        urgency_critical = {
          frame_color = "#FC2929";
          foreground = "#FFFF00";
          background = "#18191E";
          timeout = 0;
        };
      };
    };

    autorandr = {
      enable = true;
      ignoreLid = true;
    };

    redshift = {
      enable = true;
      dawnTime = "06:00";
      duskTime = "19:00";
    };

    flameshot.enable = true;
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
    packages = with pkgs;
      let
        python-packages = ps:
          with ps; [
            jedi-language-server
            debugpy
            pip
            virtualenv
            setuptools
          ];
        enhanced-python = pkgs.python310.withPackages python-packages;
      in [
        # GUI programs
        gimp
        brave
        helvum
        onlyoffice-bin

        # utils
        gnumake
        gcc
        openssl
        rclone
        neofetch
        mupdf
        ripgrep
        silver-searcher
        procs
        tree
        jq
        rsync
        xh
        dogdns
        fend
        autorandr
        ouch
        fd
        vimv-rs
        lfs
        erdtree
        xcp
        xsel
        miniserve

        # stuff not used often, installed via nix-shell
        #tokei
        #jless
        #pastel

        # stuff used for GTK theming
        gtk-engine-murrine

        # stuff used in the background
        rofi-power-menu
        rofi-rbw
        wmctrl
        bsp-layout
        alsa-utils
        mpc-cli
        uair
        bc
        ffmpeg

        # programming
        cargo
        cargo-nextest
        rustc
        go
        delve
        enhanced-python
        ruff
        black
      ] ++ lua-packages;

    file = { ".config/ruff/pyproject.toml" = { source = ./files/ruff.toml; }; };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = if theme == "dark" then "Gruvbox-Dark-BL" else "Gruvbox-Light-BL";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = if theme == "dark" then "Papirus-Dark" else "Papirus-Light";
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = if theme == "dark" then
        "Capitaine Cursors (Gruvbox) - White"
      else
        "Capitaine Cursors (Gruvbox)";
    };
  };
}
