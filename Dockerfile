FROM alpine:3.22.1

ENV USER=root

RUN apk add bash nix &&\
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable &&\
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager &&\
    nix-channel --update

RUN mkdir -p ~/.config/nix &&\
    echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

RUN nix run home-manager/master -- init --switch

WORKDIR /root/.config/home-manager/

COPY container/home.nix .
COPY container/flake.nix .
COPY theme.nix .
COPY home/scripts ./scripts
COPY home/files ./files

COPY flake.lock .

# RUN nix-shell '<home-manager>' -A install
# nix --extra-experimental-features "nix-command flakes"  run home-manager/master -- init --switch

# home-manager switch (or build)

# nix --extra-experimental-features "nix-command flakes" build --no-update-lock-file .#homeConfigurations."your.name".activationPackage

# RUN home-manager switch --flake .
# RUN nix --extra-experimental-features "nix-command flakes"  run home-manager/master -- init --switch

RUN nix run home-manager/master -- build --impure --flake .

# RUN result/activate

ENTRYPOINT ["bash"]
CMD ["-c", "result/activate && exec bash -l"]

# nix --extra-experimental-features "nix-command flakes" build --no-update-lock-file .#homeConfigurations."your.name".activationPackage

# home.x86_64-linux.homeConfigurations."your.name"

# ./result/activate

# home-manager switch --flake .

