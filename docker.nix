{
  pkgs,
  pkgs-stable,
  pkgs-custom,
  home-manager,
  colors,
  username ? "f4z3r",
  uid ? 1000,
  gid ? 1000,
}: let
  inherit (pkgs) lib;

  homeDirectory = "/home/${username}";

  #
  # Build a standalone Home Manager configuration containing only
  # the reusable development profile.
  #
  home = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit
        pkgs-stable
        pkgs-custom
        colors
        username
        ;

      # Some of your existing modules, e.g. tmux, currently expect
      # stdenv as an explicit module argument.
      stdenv = pkgs.stdenv;
    };

    modules = [
      ./home/profiles/dev.nix

      # Machine/container-specific Home Manager settings.
      {
        home = {
          inherit username homeDirectory;
          stateVersion = "26.05";
        };
      }
    ];
  };

  #
  # Home Manager generates its dotfiles in:
  #
  #   $activationPackage/home-files
  #
  # We copy that tree underneath /home/f4z3r in the image.
  #
  # The files themselves are generally symlinks into /nix/store.
  # buildLayeredImage will pull those referenced store objects into
  # the image automatically.
  #
  homeRoot = pkgs.runCommand "docker-home-${username}" {} ''
    mkdir -p "$out${homeDirectory}"

    cp -a \
      ${home.activationPackage}/home-files/. \
      "$out${homeDirectory}/"
  '';

  nixLdLibraries = with pkgs; [
    # Your additions from system/mise.nix
    stdenv.cc.cc
    zlib
    openssl
    readline
    bzip2
    sqlite
    libffi
    xz
    ncurses

    # nix-ld's normal NixOS defaults
    zstd
    curl
    attr
    libssh
    libxml2
    acl
    libsodium
    util-linux
    systemd
  ];

  nixLdEnv = pkgs.buildEnv {
    name = "nix-ld-library-path";

    paths = map lib.getLib nixLdLibraries;
    pathsToLink = ["/lib"];

    # This means the libraries end up under:
    #
    #   /share/nix-ld/lib
    #
    # when copied to the image root.
    extraPrefix = "/share/nix-ld";

    ignoreCollisions = true;

    postBuild = ''
      ln -s \
        ${pkgs.stdenv.cc.bintools.dynamicLinker} \
        $out/share/nix-ld/lib/ld.so
    '';
  };

  ldsoDir = pkgs.stdenv.hostPlatform.libDir;
  ldsoName = builtins.baseNameOf pkgs.stdenv.cc.bintools.dynamicLinker;
in
  pkgs.dockerTools.buildLayeredImage {
    name = "f4z3r-dev";
    tag = "latest";

    #
    # home.config.home.path is the buildEnv produced by Home Manager.
    #
    # It contains the executables installed by programs.* and
    # home.packages, so adding it here gives us /bin/fish,
    # /bin/nvim, /bin/tmux, git, ripgrep, etc.
    #
    contents = [
      home.config.home.path
      homeRoot

      pkgs.coreutils
      pkgs.findutils

      pkgs.bash
      pkgs.nix-ld
      nixLdEnv

      # Conventional Linux paths that programs/scripts often expect.
      pkgs.dockerTools.binSh
      pkgs.dockerTools.usrBinEnv
      pkgs.dockerTools.caCertificates

      # /etc/services, /etc/protocols, ...
      pkgs.iana-etc
    ];

    #
    # Required by dockerTools.shadowSetup when used with
    # buildLayeredImage.
    #
    enableFakechroot = true;

    #
    # Construct the small amount of traditional Linux filesystem
    # state that doesn't come from the Nix store.
    #
    fakeRootCommands = ''
      ${pkgs.dockerTools.shadowSetup}

      groupadd \
        --gid ${toString gid} \
        ${lib.escapeShellArg username}

      useradd \
        --uid ${toString uid} \
        --gid ${toString gid} \
        --home-dir ${lib.escapeShellArg homeDirectory} \
        --shell /bin/fish \
        --no-create-home \
        ${lib.escapeShellArg username}

      mkdir -p \
        ${lib.escapeShellArg homeDirectory} \
        /workspace \
        /tmp

      chown -R \
        ${toString uid}:${toString gid} \
        ${lib.escapeShellArg homeDirectory} \
        /workspace

      chmod 0700 ${lib.escapeShellArg homeDirectory}
      chmod 1777 /tmp

      cat > /etc/nsswitch.conf <<'EOF'
      passwd:   files
      group:    files
      shadow:   files
      hosts:    files dns
      networks: files
      services: files
      protocols: files
      EOF

      mkdir -p /${ldsoDir}

      ln -s \
        ${pkgs.nix-ld}/libexec/nix-ld \
        /${ldsoDir}/${ldsoName}
    '';

    config = {
      User = "${toString uid}:${toString gid}";

      WorkingDir = homeDirectory;

      Env = [
        "HOME=${homeDirectory}"
        "USER=${username}"
        "LOGNAME=${username}"
        "SHELL=/bin/fish"

        #
        # home.config.home.path is exposed as /bin through `contents`.
        # Add ~/.local/bin because several of your HM modules place
        # scripts there.
        #
        "PATH=${homeDirectory}/.local/bin:/bin:/usr/bin"

        "TERM=xterm-256color"
        "COLORTERM=truecolor"
        "LANG=C.UTF-8"

        "SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt"

        "NIX_LD=/share/nix-ld/lib/ld.so"
        "NIX_LD_LIBRARY_PATH=/share/nix-ld/lib"
      ];

      Cmd = [
        "/bin/fish"
        "-l"
      ];
    };
  }
