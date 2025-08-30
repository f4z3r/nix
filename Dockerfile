FROM alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

ENV USER=root
ENV SHELL=bash
ENV EDITOR=nvim

RUN apk add bash nix &&\
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable &&\
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager &&\
    nix-channel --update

RUN mkdir -p ~/.config/nix &&\
    echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

RUN nix run home-manager/master -- init --switch

WORKDIR /root/.config/home-manager/

COPY container/flake.nix .
COPY theme.nix .
COPY home home
# needs to be copied after home directory to override home.nix already contained there
COPY container/home.nix home/home.nix

COPY flake.lock .

RUN nix run home-manager/master -- build --no-update-lock-file --impure --flake .

ENTRYPOINT ["bash"]
CMD ["-c", "result/activate && exec $SHELL -l"]
