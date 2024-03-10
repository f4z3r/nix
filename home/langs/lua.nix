{ pkgs, lib, ... }:

let
  lua-packages = luaPkgs:
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
        version = "1.1.1-0";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/luatext-1.1.1-0.rockspec";
          sha256 = "1jy8iffvmyyg4lvlk4g6npm09447p9ii9zs0jc5j9ryly005qk27";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/f4z3r/luatext.git",
            "rev": "0f3e8b4cfacf95af6c70fedaf606cd70249c1a2d",
            "date": "2024-03-06T08:44:37+01:00",
            "path": "/nix/store/6h9v2wqjgvfgvd4dsgqnyxfdqlznkar5-luatext",
            "sha256": "1xby71jvnp4944apn6mcd95kpi2jq4vr1wrq8n3svhndfbqz1i0n",
            "hash": "sha256-FsTw8XLNwq2HRTjzkDfBUsQ7S2qsGnsVIYlcu2U4fvU=",
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
      utf8 = buildLuarocksPackage {
        pname = "utf8";
        version = "1.2-0";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/utf8-1.2-0.rockspec";
          sha256 = "10l9w1yh00m2ixicg3iwfz0zliqbbyvhw82q4xw882p89hx0r21m";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/dannote/luautf8",
            "rev": "abcf9c25e435c36788e1c9b0fc6d36b16912f1a0",
            "date": "2014-11-11T12:35:09+03:00",
            "path": "/nix/store/dfs4wp7fsycm5r5iy1cd0fi8zhk4zknz-luautf8",
            "sha256": "0lqm0c6377589dglm26n16bx3wb5yznkjcbwcl12sldzm3zr7q59",
            "hash": "sha256-qeCT/6i/US0CZXwxOe33ZfHRlwnWiEpfS6icMwwDFVM=",
            "fetchLFS": false,
            "fetchSubmodules": true,
            "deepClone": false,
            "leaveDotGit": false
          }
        '') [ "date" "path" "sha256" ]);

        disabled = luaOlder "5.1";
        propagatedBuildInputs = [ lua ];

        meta = {
          homepage = "http://github.com/starwing/luautf8";
          description = "A UTF-8 support module for Lua";
          license.fullName = "MIT";
        };
      };
      nd = buildLuarocksPackage {
        pname = "nd";
        version = "0.1.0-14";
        knownRockspec = (pkgs.fetchurl {
          url = "mirror://luarocks/nd-0.1.0-14.rockspec";
          sha256 = "0k5m6iqsz9s49fifgzrghrgdsk4103glxbj0c0fmaja52pi9zbyp";
        }).outPath;
        src = pkgs.fetchgit (removeAttrs (builtins.fromJSON ''
          {
            "url": "https://github.com/f4z3r/nd.git",
            "rev": "f2bafa24d0aa99ff1985f3c1f357a0443604f8d3",
            "date": "2024-03-10T20:19:37+01:00",
            "path": "/nix/store/lf8906j561nymqi6licbamwwp7sxx14d-nd",
            "sha256": "0a556l3jfj18vzz0hr3kapbf1lm34fhi37xf9s48rknz883xbj1a",
            "hash": "sha256-KsjVB0LfzoyITq6fEaEjo9Lg1lVzZAj+3yhIJwc1pSg=",
            "fetchLFS": false,
            "fetchSubmodules": true,
            "deepClone": false,
            "leaveDotGit": false
          }
        '') [ "date" "path" "sha256" ]);

        disabled = lua.luaversion != "5.1";
        propagatedBuildInputs = [ argparse date lua lua-path utf8 ];

        meta = {
          homepage = "https://github.com/f4z3r/nd";
          description = "Simple time tracking tool with a pomodoro timer.";
          license.fullName = "MIT <http://opensource.org/licenses/MIT>";
        };
      };
    in [ lanes lua-path lua-fun date luatext utf8 nd ] ++ [
      lyaml
      argparse
      lua-toml
      rapidjson
      basexx
      busted
      compat53
      luafilesystem

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

    ];
  luajit = pkgs.luajit.withPackages lua-packages;
in {
  home = {
    packages = with pkgs; [ lua-language-server selene luajit ];
    sessionVariables = {
      LUA_CPATH = "${lib.concatStringsSep ";"
        (map pkgs.luajitPackages.getLuaCPath [ luajit ])}";
      LUA_PATH = "./?.lua;./?/init.lua;${
          lib.concatStringsSep ";"
          (map pkgs.luajitPackages.getLuaPath [ luajit ])
        }";
    };
  };
}
