{
  pkgs,
  theme,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "Jakob Beckmann";
    userEmail = "f4z3r-github@pm.me";

    lfs = {
      enable = true;
      skipSmudge = true;
    };

    signing = {
      signer = "${pkgs.gnupg}/bin/gpg";
      signByDefault = true;
      key = "f4z3r-github@pm.me";
    };

    delta = {
      enable = true;
      options = {
        syntax-theme = "gruvbox-${theme}";
        true-color = "always";
        plus-style =
          if theme == "light"
          then "syntax #cdffcc"
          else "syntax #012800";
        minus-style =
          if theme == "light"
          then "syntax #ff8ab6"
          else "syntax #340001";
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };

    extraConfig = {
      core = {
        editor = "nvim";
      };
      advice = {
        skippedCherryPicks = false;
      };
      log = {
        date = "format:%Y-%m-%d %H:%M";
      };
      push = {
        autoSetupRemote = true;
      };
      checkout = {
        defaultRemote = "origin";
      };
      pull = {
        ff = "only";
        rebase = true;
      };
      rebase = {
        updateRefs = true;
      };
      format = {
        signoff = true;
      };
      merge = {
        tool = "nvimdiff";
      };
      mergetool = {
        keepBackup = false;
      };
      trailer = {
        ifexists = "addIfDifferent";
        separators = ":#";

        fix = {
          key = "Fix #";
        };
        coa = {
          key = "Co-authored-by: ";
          cmd = "~/.local/bin/glog-author.sh";
        };
        rel = {
          key = "Relates-to: ";
        };
        ack = {
          key = "Acked-by: ";
          cmd = "~/.local/bin/glog-author.sh";
        };
        help = {
          key = "Helped-by: ";
          cmd = "~/.local/bin/glog-author.sh";
        };
        ref = {
          key = "Reference-to: ";
          cmd = "~/.local/bin/glog-commit.sh";
        };
        see = {
          key = "See-also: ";
          cmd = "~/.local/bin/glog-commit.sh";
        };
      };
    };

    hooks = {
      commit-msg = ./hooks/commit-msg;
      pre-commit = ./hooks/pre-commit;
    };

    ignores = [
      "tags"
      "tags.temp"
      "tags.lock"
      ".mypy_cache/"
      ".ruff_cache/"
      ".pytest_cache/"
      "__pycache__/"
      ".*.un~"
      ".nvimlog"
      ".tool-versions"
      "/worktrees/"
      ".envrc"
      ".venv/"
      "/shell.nix"
      "/result"
      ".direnv/"
      ".ropeproject/"
      "/.tup/"
    ];

    aliases = {
      "t" = ''tag -n1'';
      "f" = ''fetch -q'';
      "b" = ''branch -vv'';
      "ba" = ''branch -vva'';
      "bd" = ''!git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]" { print $1 }' | xargs -tr git branch -D'';
      "d" = ''diff'';
      "aa" = ''add .'';
      "a" = ''add'';
      "acs" = ''commit -aS -s'';
      "cc" = ''commit -S -s'';
      "ca" = ''commit --amend -S -s -C HEAD'';
      "ce" = ''commit --amend -S -s'';
      "co" = ''checkout'';
      "sw" = ''switch'';
      "re" = ''reset'';
      "rebase" = ''rebase -S'';
      "s" = ''status -sb'';
      "st" = ''stash list'';
      "sh" = ''show HEAD'';
      "lg" = ''log --color --graph --pretty=format:'%Cred%h%Creset - %C(magenta)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit'';
      "rs" = ''reflog show'';
      "ph" = ''push -q'';
      "phf" = ''push -q --force-with-lease'';
      "pl" = ''pull -q'';
      "w" = ''worktree'';
      "wa" = ''worktree add -b'';
      "wl" = ''worktree list'';
      "wd" = ''!git worktree list | rg -v '\[(master|main)\]' | awk '{print $1}' | xargs -trL1 git worktree remove'';
      "wc" = ''!git branch -a --color=never | grep -v '/HEAD\\s' | sk --ansi | sed 's/^..//' | awk '{print $1}' | sed 's|^remotes/[^/]*/||' | xargs -trI'{}' git worktree add 'worktrees/{}' '{}' '';
      "bc" = ''!git branch -a --color=never | grep -v '/HEAD\\s' | sk --ansi | sed 's/^..//' | awk '{print $1}' | sed 's|^remotes/[^/]*/||' | xargs -tr git switch'';
      "gc" = ''-c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 -c gc.rerereunresolved=0 -c gc.pruneExpire=now gc'';
    };
  };

  home.file = {
    ".local/bin/glog-commit.sh" = {
      source = ./scripts/glog-commit.sh;
      executable = true;
    };
    ".local/bin/glog-author.sh" = {
      source = ./scripts/glog-author.sh;
      executable = true;
    };
    ".config/git/hooks/test-secrets.lua" = {
      source = ./hooks/test-secrets.lua;
      executable = true;
    };
  };
}
