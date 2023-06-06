{ pkgs, lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      # use all extensions
      format = lib.concatStrings [
        "$battery"
        "$custom"
        "$time"
        "$nix_shell"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$kubernetes"
        "$package"
        "$cmake"
        "$golang"
        "$helm"
        "$perl"
        "$lua"
        "$python"
        "$rust"
        "$terraform"
        "$cmd_duration"
        "$jobs"
        "╱"
        "$line_break"
        "$status"
        "$directory"
        "$character"
      ];

      battery = {
        full_symbol = "󰁹";
        charging_symbol = "󰂄";
        discharging_symbol = "󰂃";
        format = "([ $symbol$percentage ]($style))";
        display = [
          {
            threshold = 10;
            style = "bold red";
          }
          {
            threshold = 20;
            style = "bold yellow";
          }
        ];
      };

      memory_usage = {
        disabled = true;
        threshold = 75;
        symbol = "󰍛";
        style = "bold dimmed white";
        format = ''[ $symbol ''${ram} ]($style) ╱)'';
      };

      shlvl = {
        disabled = true;
        format = "[  $shlvl]($style) ╱";
        style = "bold red";
        threshold = 3;
      };

      custom = {
        shell = {
          shell = "bash";
          command = ''echo ''${CURR_SHELL:-''${SHELL}}'';
          when = ''! [[ "''${CURR_SHELL:-''${SHELL}}" =~ "zsh" ]]'';
          format = "  [$output]($style) ╱";
          style = "dimmed red";
        };
      };

      time = {
        disabled = false;
        format = "[ $time ]($style)";
        time_format = "%T";
      };

      nix_shell = {
        disabled = false;
        format = "╱ [$symbol$state(\\($name\\)) ]($style)";
        impure_msg = "[ ](bold red)";
        pure_msg = "[ ](bold green)";
        unknown_msg = "[ ](bold yellow)";
      };

      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "╱[  $user ]($style)";
        disabled = false;
      };

      hostname = {
        disabled = true;
        format =  "╱[  $hostname ]($style)";
        trim_at = ".";
        style = "dimmed bold red";
      };

      git_branch = {
        symbol = " ";
        format = "╱[ $symbol$branch ]($style)";
        style = "bold green";
        truncation_length = 18;
      };

      git_commit = {
        commit_hash_length = 7;
        tag_symbol = " ";
        tag_disabled = false;
        format = "[ $hash]($style)[($tag) ]($style)";
      };

      git_state = {
        format = ''[\($state( $progress_current/$progress_total) \)]($style)'';
        rebase = "󰃻";
        cherry_pick = "";
        merge = "";
        bisect = "󱁉";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\] ]($style))";
        style = "red";
        conflicted = "";
        ahead = ''[''${count}](yellow)'';
        behind = ''[''${count}](yellow)'';
        diverged = ''[''${ahead_count}''${behind_count}](yellow)'';
        staged = "[$count](green)";
        renamed = "󰑕";
        deleted = "󰆳";
      };

      kubernetes = {
        disabled = false;
        format = "╱ [$context $symbol $namespace ]($style)";
        style = "#BA55D3 dimmed bold";
        symbol = "󱃾";
      };

      docker_context = {
        disabled = true;
        symbol = " ";
        format = "╱ [$symbol$context ]($style)";
      };

      package = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      cmake = {
        format = "╱ [$symbol$version ]($style)";
      };

      golang = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      lua = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      nim = {
        disabled = true;
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      java = {
        disabled = true;
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      julia = {
        disabled = true;
        format = "╱ (bg:237)[$symbol$version ]($style)";
      };

      rust = {
        symbol = "󱘗 ";
        format = "╱ (bg:237)[$symbol$version ]($style)";
      };

      python = {
        symbol = "󰌠 ";
        format = "╱ [$symbol$version ($virtualenv )]($style)";
      };

      ruby = {
        disabled = true;
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      crystal = {
        disabled = true;
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      perl = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      helm = {
        symbol = "󰠳 ";
        format = "╱ [$symbol$version ]($style)";
      };

      nodejs = {
        disabled = true;
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      ocaml = {
        disabled = true;
        symbol = " ";
        format = "╱ [$symbol$version (\\(switch_indicator$switch_name\\))]($style)";
      };

      terraform = {
        symbol = "󰇧 ";
        format = "╱ [$symbol$workspace ]($style)";
      };

      # TODO(@jakob): add langs here

      gcloud = {
        disabled = true;
        symbol = "";
        format = "╱ [$symbol ]($style)";
      };

      cmd_duration = {
        min_time = 500;
        show_milliseconds = false;
        format = "╱ [took](dimmed)[ $duration ]($style)";
        style = "bold yellow";
        # show_notification = true;
        # min_time_to_notify = 10_000;
      };

      jobs = {
        symbol = "󰣏";
        format = "╱ [$symbol$number ]($style)";
      };

      # NOTE(@jakob): new line from here on
      line_break = {
        disabled = false;
      };

      status = {
        symbol = "";
        format = ''[\[>> $symbol $status <<\]](dimmed bold red) '';
        disabled = false;
      };

      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = "";
        style = "underline bold dimmed cyan";
        format = "([$read_only]($read_only_style) )[$path]($style) ";
      };

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
        vimcmd_symbol = "[](bold green)";
        vimcmd_replace_one_symbol = "[](bold purple)";
        vimcmd_replace_symbol = "[](bold purple)";
        vimcmd_visual_symbol = "[](bold yellow)";
      };
    };
  };
}
