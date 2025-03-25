{
  pkgs,
  lib,
  stdenv,
  theme,
  ...
}: let
  fg_colour =
    if theme == "dark"
    then "colour230"
    else "colour236";
  bg_colour =
    if theme == "dark"
    then "colour236"
    else "colour180";
  focus_colour = "colour214";

  rtpPath = "share/tmux-plugins";

  addRtp = path: rtpFilePath: attrs: derivation:
    derivation
    // {rtp = "${derivation}/${path}/${rtpFilePath}";}
    // {
      overrideAttrs = f: mkTmuxPlugin (attrs // f attrs);
    };

  mkTmuxPlugin = a @ {
    pluginName,
    rtpFilePath ? (builtins.replaceStrings ["-"] ["_"] pluginName) + ".tmux",
    namePrefix ? "tmuxplugin-",
    src,
    unpackPhase ? "",
    configurePhase ? ":",
    buildPhase ? ":",
    addonInfo ? null,
    preInstall ? "",
    postInstall ? "",
    path ? lib.getName pluginName,
    ...
  }:
    if lib.hasAttr "dependencies" a
    then throw "dependencies attribute is obselete. see NixOS/nixpkgs#118034" # added 2021-04-01
    else
      addRtp "${rtpPath}/${path}" rtpFilePath a (stdenv.mkDerivation (a
        // {
          pname = namePrefix + pluginName;

          inherit pluginName unpackPhase configurePhase buildPhase addonInfo preInstall postInstall;

          installPhase = ''
            runHook preInstall

            target=$out/${rtpPath}/${path}
            mkdir -p $out/${rtpPath}
            cp -r . $target
            if [ -n "$addonInfo" ]; then
              echo "$addonInfo" > $target/addon-info.json
            fi

            runHook postInstall
          '';
        }));
in {
  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "a";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    aggressiveResize = true;
    historyLimit = 10000;
    resizeAmount = 5;
    escapeTime = 0;
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = yank;
        extraConfig = ''
          set -g @yank_selection 'clipboard'
          set -g @yank_action 'copy-pipe'
          set -g @shell_mode 'vi'
          set -g @override_copy_command 'wl-copy'
        '';
      }
      {
        plugin = copycat;
        extraConfig = ''set -g @override_copy_command "wl-copy"'';
      }
      {
        plugin = mkTmuxPlugin {
          pluginName = "tea";
          version = "unstable-2024-06-02";
          src = pkgs.fetchFromGitHub {
            owner = "f4z3r";
            repo = "tmux-tea";
            rev = "d56a0bb0f7c2e796d4da3d9bf18f4e0e4fae1965";
            hash = "sha256-X0bcnrJDPOGhDZcD7pc7igJI+bPJdIacssEjiXEcUEA=";
          };
        };
        extraConfig = ''
          set -g @tea-session-name "full-path"
        '';
      }
      {
        plugin = tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-unique enabled
          set -g @thumbs-alphabet colemak
          set -g @thumbs-command "echo -n {} | wl-copy"
          set -g @thumbs-upcase-command "tmux set-buffer -- {} && tmux paste-buffer"
          set -g @thumbs-regexp-1 'sha256\-\S{44}' # Match Nix SHAs
        '';
      }
    ];

    extraConfig = ''
      # turn of mouse
      set -g mouse off

      set -g status on

      set -g base-index 1

      # improve default name of windows
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}: #{b:pane_current_command}'

      # passthrough for zen-mode
      set-option -g allow-passthrough on

      # minimal status bar
      set-option -g status-style bg=${bg_colour},fg=${fg_colour}
      set-option -g status-left ""
      set-option -g status-right ""
      set -g status-justify centre
      set-window-option -g window-status-separator "    "
      set-window-option -g window-status-current-format "#{?window_zoomed_flag,#[fg=${focus_colour}],}"
      set-window-option -g window-status-format ""

      # fix coloring for tmux
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"

      # override suspend
      bind-key C-z resize-pane -Z

      # popup
      bind-key -n C-s if-shell -F '#{==:#{=5:session_name},popup}' {
        detach-client
      } {
        run-shell -b ~/.local/bin/tmux-popup.sh
      }

      # git
      bind-key -n C-g display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E "${pkgs.lazygit}/bin/lazygit"

      # broot
      bind-key -n C-b display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E "${pkgs.broot}/bin/broot"

      # window tree
      bind-key -r w run-shell 'tmux choose-tree -wf"##{==:##{session_name},#{session_name}}" -F "##{window_name}"'

      # better movement
      bind-key -n Pageup copy-mode\;\
          send-keys -X start-of-line\;\
          send-keys -X search-backward " :: "
      bind-key -T copy-mode -n Pageup send-keys -X halfpage-up
      bind-key -T copy-mode -n Pagedown send-keys -X halfpage-down
      bind-key -T copy-mode-vi Pageup send-keys -X halfpage-up
      bind-key -T copy-mode-vi Pagedown send-keys -X halfpage-down

      # vim like pane movement
      bind-key C-h select-pane -t '{left-of}'
      bind-key C-l select-pane -t '{right-of}'
      bind-key C-k select-pane -t '{up-of}'
      bind-key C-n select-pane -t '{down-of}'

      # resize with arrow keys
      bind-key Right resize-pane -R 5
      bind-key Left resize-pane -L 5
      bind-key Up resize-pane -U 5
      bind-key Down resize-pane -D 5

      # Similar split to screen
      bind-key | split-window -h -c "#{pane_current_path}"
      bind-key - split-window -v -c "#{pane_current_path}"

      # ensure all window are in same working dir
      bind-key a last-window
      bind-key c new-window -c "#{pane_current_path}"
      bind-key % split-window -h -c "#{pane_current_path}"
      bind-key '"' split-window -v -c "#{pane_current_path}"

      # use v to select line and r for rectangle selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      # easy scrolling
      bind-key -T copy-mode-vi C-p send-keys -X scroll-up
      bind-key -T copy-mode-vi C-n send-keys -X scroll-down
      bind-key -T copy-mode-vi C-l send-keys -X end-of-line
      bind-key -T copy-mode-vi C-h send-keys -X start-of-line
      bind-key -T copy-mode-vi j send-keys -X cursor-down
      bind-key -T copy-mode-vi k send-keys -X cursor-up
      bind-key -T copy-mode-vi h send-keys -X cursor-left
      bind-key -T copy-mode-vi l send-keys -X cursor-right
    '';
  };
  home.file = {
    ".local/bin/tmux-popup.sh" = {
      source = ./scripts/tmux-popup.sh;
      executable = true;
    };
  };
}
