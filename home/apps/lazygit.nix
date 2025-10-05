{colors, ...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        mouseEvents = false;
        timeFormat = "2024-12-31";
        shortTimeFormat = "15:30";
        nerdFontsVersion = "3";
        scrollPastBottom = false;
        showCommandLog = false;
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --paging=never --${colors.theme}";
          # externalDiffCommand = "delta";
        };
        merging = {
          args = "--ff-only";
        };
        commit = {
          signOff = true;
        };
        autoForwardBranches = "allBranches";
        branchLogCmd = "git log --color --graph --pretty=format:'%Cred%h%Creset - %C(magenta)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit --";
        allBranchesLogCmds = [
          "git log --all --color --graph --pretty=format:'%Cred%h%Creset - %C(magenta)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit"
        ];
        parseEmoji = true;
      };
      notARepository = "quit";
      keybinding = {
        universal = {
          return = "<esc>";
          nextItem-alt = "n";
          prevItem-alt = "k";
          nextMatch = "j";
          prevMatch = "J";
          new = "j";
          scrollDownMain-alt1 = "J";
        };
        files = {
          commitChangesWithEditor = "<c-n>";
        };
      };
    };
  };
}
