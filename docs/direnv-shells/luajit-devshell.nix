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
          lua-packages = with pkgs.luajitPackages; [
            rapidjson
            luasocket
            luasec
            luafilesystem
            penlight
          ];
        in
        with pkgs;
        {
          devShell = mkShell {
            buildInputs = [
              luajit
            ] ++ lua-packages;
            shellHook = with pkgs.luajitPackages; ''
              export LUA_CPATH="${lib.concatStringsSep ";" (map getLuaCPath lua-packages)}"
              export LUA_PATH="${lib.concatStringsSep ";" (map getLuaPath lua-packages)}"
            '';
          };
        }
      );
}
