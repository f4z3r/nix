{ pkgs, lib, pkgs-custom, hostname, username, theme ? "dark", polybar_dpi
, font_size, scratch_res, main_monitor, monitor_prefix, ... }:

assert lib.asserts.assertOneOf "theme" theme [ "dark" "light" ];

let
  custom-lua-packages = luaPkgs:
    with luaPkgs;
    let
      # to generate new packages:
      # ```bash
      # luarocks nix <package>
      # ```
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
        externalDeps = [{
          name = "PTHREAD";
          dep = pkgs.glibc;
        }];

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
      luatext = buildLuarocksPackage {
        pname = "luatext";
        version = "1.1.0-0";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/luatext-1.1.0-0.rockspec";
          sha256 = "07cdxz536xk00g7m43jaqrx6ydgk75kjnrpzf6c3gb7s6bnc1p45";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/f4z3r/luatext.git",
            "rev": "0a9d8dcf2df44ece066aeba87e5c26e29566cbac",
            "date": "2024-03-05T21:36:00+01:00",
            "path": "/nix/store/vlwgf2675pnzhnpksaiyyihhx9gh05b1-luatext",
            "sha256": "0aglknmwpf3qhy5z1vmw1hnpnbps7gpl6fxdgzx831dqkxn7g083",
            "hash": "sha256-A4F3bJ+4hYH6f607Q+87+i57LQy87vCLh3i4y6ud9Ck=",
            "fetchLFS": false,
            "fetchSubmodules": true,
            "deepClone": false,
            "leaveDotGit": false
          }
        '') [ "date" "path" "sha256" ]);

        disabled = luaOlder "5.1";
        propagatedBuildInputs = [ lua ];

        meta = {
          homepage = "https://github.com/f4z3r/luatext/tree/main";
          description = "A small library to print colored text";
          license.fullName = "MIT";
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
      luastatic = buildLuarocksPackage {
        pname = "luastatic";
        version = "0.0.12-1";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/luastatic-0.0.12-1.rockspec";
          sha256 = "0mai46i5ddx6f8j71y3ibr1whnhqcanvwsg5xw6vkywf1ki6mp4c";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/ers35/luastatic.git",
            "rev": "a1bb249dbbd1263ca63696455fdf7c613f417f32",
            "date": "2020-06-13T23:30:34-07:00",
            "path": "/nix/store/ff6jqlqpk21x28dznw2iv23aaspw7q5g-luastatic",
            "sha256": "0frvjgdcq8vmsjmn5znba2zj398vbqqqkaks277r2xcyw4n8wnrj",
            "hash": "sha256-MluOLOGedZHPEXqqiTFeG6Uhv1DL/mKr1HUjzNqTOzs=",
            "fetchLFS": false,
            "fetchSubmodules": true,
            "deepClone": false,
            "leaveDotGit": false
          }
        '') [ "date" "path" "sha256" ]);

        disabled = luaOlder "5.1";
        propagatedBuildInputs = [ lua ];

        meta = {
          homepage = "https://www.github.com/ers35/luastatic";
          description = "Build a standalone executable from a Lua program.";
          license.fullName = "CC0";
        };
      };
    in [ lanes lua-path lua-fun lua-log date luatext luastatic ];
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
      luafilesystem
      luautf8

      # needed for publishing rocks
      luarocks-nix
      cjson

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
    (import ./apps/bspwm/default.nix {
      inherit pkgs hostname scratch_res main_monitor monitor_prefix;
    })
    (import ./apps/sxhkd/default.nix { inherit pkgs username; })
    (import ./apps/polybar/default.nix {
      inherit pkgs polybar_dpi main_monitor monitor_prefix;
    })
    ./apps/picom.nix
    ./apps/rofi/default.nix
    (import ./apps/git/default.nix { inherit pkgs theme; })
    (import ./apps/wezterm.nix { inherit pkgs theme font_size; })
    (import ./apps/tmux/default.nix { inherit pkgs theme; })
    (import ./apps/zsh/default.nix { inherit lib pkgs theme lua-packages; })
    ./apps/starship.nix
    ./apps/gpg.nix
    ./apps/nvim/default.nix
    ./apps/broot.nix
    ./apps/k9s/default.nix
    (import ./apps/bat.nix { inherit pkgs theme; })
    (import ./apps/mpd/default.nix { inherit pkgs username; })
  ];

  programs = {
    home-manager.enable = true;

    mpv.enable = true;

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
        pinentry = "qt";
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

    eza = {
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
        python-packages = ps: with ps; [ debugpy pip virtualenv setuptools ];
        enhanced-python = pkgs.python311.withPackages python-packages;
      in [
        # GUI programs
        gimp
        brave
        helvum
        onlyoffice-bin
        obs-studio
        flowblade
        signal-desktop

        # utils
        lua-language-server
        selene
        zip
        just
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
        dysk
        erdtree
        xcp
        xsel
        miniserve
        hoard
        vhs
        pandoc
        slides

        # stuff not used often, installed via nix-shell
        #tokei
        #jless
        #pastel

        # stuff used for GTK theming
        gtk-engine-murrine

        # stuff used in the background
        yt-dlp
        rofi-power-menu
        rofi-rbw
        wmctrl
        alsa-utils
        mpc-cli
        uair
        bc
        ffmpeg
        fzf

        # programming
        cargo
        cargo-nextest
        rustc
        go
        delve
        enhanced-python
        ruff
        black
        hatch
        dive
        kubectl
        kubectx
        kubernetes-helm
        terraform

        # python language server
        nodePackages.pyright
      ] ++ lua-packages;

    file = {
      ".config/ruff/pyproject.toml" = { source = ./files/ruff.toml; };
      "revive.toml" = { source = ./files/revive.toml; };
      ".local/share/uair/notification-sound.wav" = {
        source = ./files/notification-sound.wav;
      };
    };
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
