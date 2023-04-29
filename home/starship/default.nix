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
        "$memory_usage"
        "$shlvl"
        "$custom"
        "$time"
        "$nix_shell"
        "$username"
        "$hostname"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$kubernetes"
        "$hg_branch"
        "$docker_context"
        "$package"
        "$cmake"
        "$dart"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$golang"
        "$helm"
        "$java"
        "$julia"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$perl"
        "$lua"
        "$php"
        "$purescript"
        "$python"
        "$ruby"
        "$crystal"
        "$rust"
        "$swift"
        "$terraform"
        "$zig"
        "$conda"
        "$aws"
        "$gcloud"
        "$openstack"
        "$env_var"
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
        charging_symbol = "󰢝 ";
        discharging_symbol = "󱃌";
        format = "([ $symbol$percentage ]($style))";
        display = [
          {
            threshold = 10;
            style = "bold red";
          }
          {
            threshold = 30;
            style = "bold yellow";
          }
        ];
      };

      memory_usage = {
        disabled = false;
        threshold = 75;
        symbol = "󰍛";
        style = "bold dimmed white";
        format = ''[ $symbol ''${ram} ]($style) ╱)'';
      };

      shlvl = {
        disabled = false;
        format = "[  $shlvl]($style) ╱";
        style = "bold red";
        threshold = 2;
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
        format = "╱ [$symbol$state]($style)";
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
        format =  "╱[  $hostname ]($style)";
        trim_at = ".";
        style = "dimmed bold red";
      };

      git_branch = {
        symbol = " ";
        format = "╱[ $symbol$branch ]($style)";
        style = "bold green";
        truncation_length = 18;
      };

      git_commit = {
        commit_hash_length = 7;
        tag_symbol = " ";
        tag_disabled = false;
        format = "[ $hash]($style)[($tag) ]($style)";
      };

      git_state = {
        format = ''[\($state( $progress_current/$progress_total) \)]($style)'';
        rebase = "󰃻";
        cherry_pick = " ";
        merge = " ";
        bisect = "󱁉 ";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\] ]($style))";
        style = "red";
        conflicted = "";
        ahead = ''[  ''${count}](yellow)'';
        behind = ''[  ''${count}](yellow)'';
        diverged = ''[   ''${ahead_count}  ''${behind_count}](yellow)'';
        staged = "[ \\($count\\)](green)";
        renamed = "󰑕";
        deleted = "󰆳";
      };

      kubernetes = {
        disabled = false;
        format = "╱ [$context $symbol $namespace ](style)";
        style = "#BA55D3 dimmed bold";
        symbol = "󱃾 ";
      };

      docker_context = {
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
        symbol = "ﳑ ";
        format = "╱ [$symbol$version ]($style)";
      };

      lua = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      nim = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      java = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      julia = {
        format = "╱ (bg:237)[$symbol$version ]($style)";
      };

      rust = {
        symbol = " ";
        format = "╱ (bg:237)[$symbol$version ]($style)";
      };

      python = {
        symbol = " ";
        format = "╱ [$symbol$version ($virtualenv )]($style)";
      };

      ruby = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      crystal = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      perl = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      helm = {
        symbol = "ﴱ ";
        format = "╱ [$symbol$version ]($style)";
      };

      nodejs = {
        symbol = " ";
        format = "╱ [$symbol$version ]($style)";
      };

      ocaml = {
        symbol = " ";
        format = "╱ [$symbol$version (\\(switch_indicator$switch_name\\))]($style)";
      };

      terraform = {
        symbol = " ";
        format = "╱ [$symbol$workspace ]($style)";
      };

      # TODO(@jakob): add langs here

      gcloud = {
        symbol = "";
        disabled = true;
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
        format = "╱ [$symbol$number ]($style)";
      };

      # NOTE(@jakob): new line from here on
      line_break = {
        disabled = false;
      };

      status = {
        symbol = "";
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
    };
  };
}
