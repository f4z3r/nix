{lib, ...}: {
  programs.fish = {
    shellAbbrs.sys = "systemctl";

    shellAliases = {
      wall = ''awww img (fd . ~/.local/share/wallpapers/ | shuf -n 1)'';
      pdf = "mupdf";
      imv = "imv -b ffffff";
      jwt = "wl-paste | step crypto jwt inspect --insecure | jq";
      ns = ''rclone bisync gdrive-crypt:/ ~/notes --remove-empty-dirs --filter "- /.**" --filter "- **/.**" --filter "- **/tags"  --compare size,modtime -MP --fix-case --conflict-suffix upstream,local'';

      gateway-up = ''podman compose -f /home/f4z3r/opt/f4z3r/agentic-factory/compose.yaml up -d'';
      gateway-down = ''podman compose -f /home/f4z3r/opt/f4z3r/agentic-factory/compose.yaml down'';
      pi = ''PI_WORKSPACE="$PWD" podman compose -f /home/f4z3r/opt/f4z3r/agentic-factory/compose.yaml --profile agent run --rm pi'';
    };

    shellInit = lib.mkAfter ''
      if test -r "$HOME/.config/f4z3r/secrets.fish"
        source "$HOME/.config/f4z3r/secrets.fish"
      end
    '';
  };
}
