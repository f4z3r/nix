{lib, ...}: {
  programs.fish = {
    shellAbbrs.sys = "systemctl";

    shellAliases = {
      wall = ''awww img (fd . ~/.local/share/wallpapers/ | shuf -n 1)'';
      pdf = "mupdf";
      imv = "imv -b ffffff";
      jwt = "wl-paste | step crypto jwt inspect --insecure | jq";
      ns = ''rclone bisync gdrive-crypt:/ ~/notes --remove-empty-dirs --filter "- /.**" --filter "- **/.**" --filter "- **/tags"  --compare size,modtime -MP --fix-case --conflict-suffix upstream,local'';

      gateway-up = ''chmod a+r /home/f4z3r/opt/f4z3r/agentic-factory/gateway/config.yaml; chmod -R a+r /home/f4z3r/opt/f4z3r/agentic-factory/mcp; podman compose -f /home/f4z3r/opt/f4z3r/agentic-factory/compose.yaml up -d'';
      gateway-down = ''podman compose -f /home/f4z3r/opt/f4z3r/agentic-factory/compose.yaml down'';
    };

    shellInit = lib.mkAfter ''
      if test -r "$HOME/.config/f4z3r/secrets.fish"
        source "$HOME/.config/f4z3r/secrets.fish"
      end

      function pi-sandbox
          set -l root (git rev-parse --show-toplevel 2>/dev/null)
          if test -z "$root"
              set root $PWD
          end
          set -l project (basename "$root")
          env PI_WORKSPACE="$root" PI_PROJECT_NAME="$project" \
              podman compose \
              -f /home/f4z3r/opt/f4z3r/agentic-factory/compose.yaml \
              --profile agent \
              run --rm pi
      end
    '';
  };
}
