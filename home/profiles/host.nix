{lib, ...}: {
  programs.fish = {
    shellAbbrs.sys = "systemctl";

    shellAliases = {
      wall = ''awww img (fd . ~/.local/share/wallpapers/ | shuf -n 1)'';
      pdf = "mupdf";
      imv = "imv -b ffffff";
      jwt = "wl-paste | step crypto jwt inspect --insecure | jq";
      ns = ''rclone bisync gdrive-crypt:/ ~/notes --remove-empty-dirs --filter "- /.**" --filter "- **/.**" --filter "- **/tags"  --compare size,modtime -MP --fix-case --conflict-suffix upstream,local'';

      pi = ''
        docker run --rm -it \
          -e OPENROUTER_API_KEY \
          -e BRAVE_API_KEY \
          -v ~/.pi:/home/f4z3r/.pi \
          -v ~/notes/resources/ai/:/home/f4z3r/notes/resources/ai \
          -v .:/home/f4z3r/workspace \
          ghcr.io/f4z3r/pi-agent-image:v0.5.4 pi
      '';
    };

    shellInit = lib.mkAfter ''
      if test -r "$HOME/.config/f4z3r/secrets.fish"
        source "$HOME/.config/f4z3r/secrets.fish"
      end
    '';
  };
}
