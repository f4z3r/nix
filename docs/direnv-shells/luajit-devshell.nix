{
  description = "LuaJIT Dev Shell";
  inputs = {
    nixpkgs.url = "nixpkgs/release-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          pkgs-unstable = import nixpkgs-unstable { inherit system; };
          custom-lua-packages = luaPkgs: let
            # generated with `luarocks-nix lua-path`
            lua-path = luaPkgs.buildLuarocksPackage {
              pname = "lua-path";
              version = "0.3.1-2";
              knownRockspec = (pkgs.fetchurl {
                url    = "mirror://luarocks/lua-path-0.3.1-2.rockspec";
                sha256 = "1y0r23bbqhrd3wl7f5fpm1fqijb5sar59if4cif1j789rymf43z2";
              }).outPath;
              src = pkgs.fetchzip {
                url    = "https://github.com/moteus/lua-path/archive/v0.3.1.zip";
                sha256 = "1v65rsakwi1n64v3ylpsyml9dg8kac8c1glnlng0ccrqnlw6jzka";
              };

              disabled = (luaPkgs.luaOlder "5.1") || (luaPkgs.luaAtLeast "5.5");
              propagatedBuildInputs = [ luaPkgs.lua ];

              meta = {
                homepage = "https://github.com/moteus/lua-path";
                description = "File system path manipulation library";
                license.fullName = "MIT/X11";
              };
            };
          in
            with luaPkgs;
              [
                lua-path
              ];
          lua-packages = with pkgs.luajitPackages; [
            rapidjson
            luasocket
            luasec
            luafilesystem
            penlight
          ] ++ [(pkgs.luajit.withPackages custom-lua-packages)];
        in
        with pkgs;
        {
          devShell = mkShell {
            buildInputs = [
                # system requirements
            ] ++ lua-packages;
            shellHook = with pkgs.luajitPackages; ''
              export LUA_CPATH="${lib.concatStringsSep ";" (map getLuaCPath lua-packages)}"
              export LUA_PATH="${lib.concatStringsSep ";" (map getLuaPath lua-packages)}"
            '';
          };
        }
      );
}
