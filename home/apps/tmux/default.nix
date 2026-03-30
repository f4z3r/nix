{
  pkgs,
  lib,
  stdenv,
  colors,
  ...
}: let
  fg_colour =
    if colors.theme == "dark"
    then "colour230"
    else "colour236";
  bg_colour =
    if colors.theme == "dark"
    then "colour236"
    else "colour180";
  focus_colour = "colour214";
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
        plugin = tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-unique enabled
          set -g @thumbs-reverse enabled
          set -g @thumbs-alphabet colemak-homerow
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

      # passthrough for zen-mode and nvim clipboard
      set-option -gq allow-passthrough on
      set-option -gq set-clipboard on

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

      # window tree
      bind-key -r w run-shell 'tmux choose-tree -wf"##{==:##{session_name},#{session_name}}" -F "##{window_name}"'

      # better movement
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

      bind-key t split-window -v -l 15 -c "#{pane_current_path}"

      # ensure all window are in same working dir
      bind-key C-a last-window
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

      # quick switch to previous session
      bind-key -n C-y run-shell -b ~/.local/bin/last-session.sh

      source-file -q ~/.config/tmux/overrides
    '';
  };
  home.file = {
    ".local/bin/tmux-popup.sh" = {
      source = ./scripts/tmux-popup.sh;
      executable = true;
    };
    ".local/bin/last-session.sh" = {
      source = ./scripts/last-session.sh;
      executable = true;
    };
  };
}
