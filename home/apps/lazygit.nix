{
  pkgs,
  theme,
  ...
}: {
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
          pager = "delta --paging=never --${theme}";
          # externalDiffCommand = "delta";
        };
        merging = {
          args = "--ff-only";
        };
        branchLogCmd = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit";
        allBranchesLogCmd = "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit";
        parseEmoji = true;
      };
      os = {
        editPresent = "nvim";
      };
      notARepository = "quit";
      keybinding = {
        universal = {
          return = "<c-y>";
          nextItem-alt = "n";
          prevItem-alt = "k";
          nextMatch = "j";
          prevMatch = "J";
          new = "j";
          scrollDownMain-alt1 = "J";
        };
      };
      customCommands = [
        {
          key = "<c-n>";
          description = "Commit stuff";
          command = ''git commit -S -m {{ printf "%s%s: %s" .Form.CommitType .Form.Scope .Form.Message | quote }} --trailer={{ .Form.Trailer | quote }}'';
          context = "files";
          prompts = [
            {
              type = "menu";
              key = "CommitType";
              title = "Type: what commit type is this?";
              options = [
                {
                  value = "feat";
                  description = "for a new feature for the user, not a new feature for build script";
                }
                {
                  value = "impr";
                  description = "for a smaller improvements that are not features";
                }
                {
                  value = "fix";
                  description = "for a bug fix for the user, not a fix to a build script";
                }
                {
                  value = "test";
                  description = "for adding missing tests, refactoring tests; no production code change";
                }
                {
                  value = "chore";
                  description = "for a chore that does not fit in other categories";
                }
                {
                  value = "docs";
                  description = "for changes to the documentation";
                }
                {
                  value = "style";
                  description = "for formatting changes, missing semicolons, etc";
                }
                {
                  value = "refactor";
                  description = "for refactoring production code, e.g. renaming a variable";
                }
                {
                  value = "ci";
                  description = "for changes to the CI";
                }
                {
                  value = "perf";
                  description = "for performance improvements";
                }
                {
                  value = "build";
                  description = "for updating build configuration, development tools or other changes irrelevant to the user";
                }
              ];
            }
            {
              type = "input";
              key = "Scope";
              title = "Scope: what is the scope of the commit? Add parentheses around it.";
            }
            {
              type = "input";
              key = "Message";
              title = "Message: what is this commit about?";
            }
            {
              type = "input";
              key = "Trailer";
              title = "Trailer: add a trailer.";
            }
          ];
        }
      ];
    };
  };
}
