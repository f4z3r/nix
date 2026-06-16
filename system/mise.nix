{
  pkgs,
  stdenv,
}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      readline
      bzip2
      sqlite
      libffi
      xz
      ncurses
    ];
  };
}
