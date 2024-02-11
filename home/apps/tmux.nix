{ pkgs, theme, ... }:
let
  fg_colour = if theme == "dark" then "colour230" else "colour236";
  bg_colour = if theme == "dark" then "colour236" else "colour180";
  focous_colour = "colour214";

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
        '';
      }
      {
        plugin = copycat;
        extraConfig =
          ''set -g @override_copy_command "(xsel -cb && xsel -bi)"'';
      }
    ];

    extraConfig = ''
      # turn of mouse
      set -g mouse off

      set -g status on

      # improve default name of windows
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}: #{b:pane_current_command}'

      # minimal status bar
      set-option -g status-style bg=${bg_colour},fg=${fg_colour}
      set-option -g status-left ""
      set-option -g status-right ""
      set -g status-justify centre
      set-window-option -g window-status-separator "    "
      set-window-option -g window-status-current-format "#{?window_zoomed_flag,#[fg=${focous_colour}],}"
      set-window-option -g window-status-format ""

      # fix coloring for tmux
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"

      # override suspend
      bind-key C-z resize-pane -Z

      # popup
      bind-key -n M-f if-shell -F '#{==:#{=5:session_name},popup}' {
        detach-client
      } {
        display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E 'tmux attach-session -t popup || tmux new-session -s popup'
      }

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
}
