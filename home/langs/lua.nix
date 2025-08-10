{
  pkgs,
  lib,
  username,
  ...
}: let
  luajit = import ./luajit.nix {inherit pkgs;};
in {
  home = {
    packages = with pkgs; [lua-language-server selene luajit];
    sessionVariables = {
      LUA_CPATH = "${lib.concatStringsSep ";"
        (map pkgs.luajitPackages.getLuaCPath [luajit])}";
      LUA_PATH = "${
        lib.concatStringsSep ";"
        ([
            "./?.lua"
            "./?/init.lua"
            "/home/${username}/.luarocks/share/lua/5.1/?.lua"
            "/home/${username}/.luarocks/share/lua/5.1/?/init.lua"
          ]
          ++ (map pkgs.luajitPackages.getLuaPath [luajit]))
      }";
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
  };

  home.file.".config/sofa/config.yaml" = {
    source = ../files/sofa.yaml;
  };
}
