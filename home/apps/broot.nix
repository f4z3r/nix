{
  pkgs,
  theme,
  ...
}: {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = false;
      imports = [];
      capture_mouse = false;
      true_colors = true;
      show_selection_mark = true;
      default_flags = "gip";
      special_paths = {
        worktrees = {
          show = "never";
        };
        build = {
          show = "never";
        };
      };
      ext_colors = {
        rs = "rgb(255, 128, 75)";
        js = "rgb(255, 128, 75)";
        py = "rgb(255, 128, 75)";
        go = "rgb(255, 128, 75)";
        ts = "rgb(255, 128, 75)";
        sh = "rgb(255, 128, 75)";
        vim = "rgb(255, 128, 75)";
        lua = "rgb(255, 128, 75)";
        rb = "rgb(255, 128, 75)";
        rockspec = "rgb(255, 128, 75)";
        log = "red";
        png = "blue";
        jpeg = "blue";
        jpg = "blue";
        gif = "blue";
        yaml = "yellow";
        json = "yellow";
        hjson = "yellow";
        conf = "yellow";
        md = "green";
        txt = "green";
        cheat = "green";
        css = "green";
        html = "green";
      };
      verbs = [
        {
          key = "ctrl-p";
          internal = ":line_up";
        }
        {
          key = "ctrl-n";
          internal = ":line_down";
        }
        {
          key = "ctrl-l";
          internal = ":panel_right";
        }
        {
          key = "ctrl-h";
          internal = ":panel_left";
        }
        {
          key = "ctrl-t";
          internal = ":toggle_stage";
        }
        {
          key = "ctrl-f";
          cmd = ":cd";
        }
        {
          name = "touch";
          shortcut = "t";
          invocation = "touch {new_file}";
          external = ["touch" "{directory}/{new_file}"];
          leave_broot = false;
        }
        {
          name = "exec";
          shortcut = "x";
          apply_to = "file";
          external = ["chmod" "+x" "{file}"];
          leave_broot = false;
        }
        {
          name = "vimv";
          shortcut = "v";
          apply_to = "file";
          external = ["vimv" "{file}"];
          working_dir = "{directory}";
          leave_broot = false;
          switch_terminal = true;
          panels = ["tree"];
        }
        {
          name = "vimv";
          shortcut = "v";
          apply_to = "directory";
          external = ["vimv"];
          working_dir = "{directory}";
          leave_broot = false;
          switch_terminal = true;
          panels = ["tree"];
        }
        {
          invocation = "edit";
          shortcut = "ed";
          key = "ctrl-e";
          apply_to = "file";
          external = ["nvim" "+{line}" "{file}"];
          set_working_dir = true;
          leave_broot = false;
        }
        {
          invocation = "edit_leave";
          shortcut = "e";
          apply_to = "file";
          external = ["nvim" "+{line}" "{file}"];
          set_working_dir = true;
          leave_broot = true;
        }
        {
          invocation = "create {subpath}";
          shortcut = "c";
          external = ["nvim" "{directory}/{subpath}"];
          leave_broot = false;
        }
        {
          invocation = "git_diff";
          shortcut = "gd";
          leave_broot = false;
          external = ["git" "diff" "{file}"];
        }
        {
          apply_to = "file";
          external = ["echo" "-n" "{file}"];
          key = "enter";
        }
        {
          name = "yank";
          shortcut = "y";
          external = ["wl-copy" "{file}"];
          leave_broot = false;
        }
      ];
      skin =
        if theme == "dark"
        then {
          default = "rgb(235, 219, 178) none / rgb(189, 174, 147) none";
          tree = "rgb(70, 70, 80) None / rgb(60, 60, 60) None";
          parent = "rgb(235, 219, 178) none / rgb(189, 174, 147) none Italic";
          file = "None None / None  None Italic";
          directory = "rgb(131, 165, 152) None Bold / rgb(131, 165, 152) None";
          exe = "rgb(184, 187, 38) None";
          link = "rgb(104, 157, 106) None";
          pruning = "rgb(124, 111, 100) None Italic";
          perm__ = "None None";
          perm_r = "rgb(215, 153, 33) None";
          perm_w = "rgb(204, 36, 29) None";
          perm_x = "rgb(152, 151, 26) None";
          owner = "rgb(215, 153, 33) None Bold";
          group = "rgb(215, 153, 33) None";
          count = "rgb(69, 133, 136) rgb(50, 48, 47)";
          dates = "rgb(168, 153, 132) None";
          sparse = "rgb(250, 189,47) None";
          content_extract = "ansi(29) None Italic";
          content_match = "ansi(34) None Bold";
          git_branch = "rgb(251, 241, 199) None";
          git_insertions = "rgb(152, 151, 26) None";
          git_deletions = "rgb(190, 15, 23) None";
          git_status_current = "rgb(60, 56, 54) None";
          git_status_modified = "rgb(152, 151, 26) None";
          git_status_new = "rgb(104, 187, 38) None Bold";
          git_status_ignored = "rgb(213, 196, 161) None";
          git_status_conflicted = "rgb(204, 36, 29) None";
          git_status_other = "rgb(204, 36, 29) None";
          selected_line = "None rgb(60, 56, 54) / None rgb(50, 48, 47)";
          char_match = "rgb(250, 189, 47) None";
          file_error = "rgb(251, 73, 52) None";
          flag_label = "rgb(189, 174, 147) None";
          flag_value = "rgb(211, 134, 155) None Bold";
          input = "rgb(251, 241, 199) None / rgb(189, 174, 147) None Italic";
          status_error = "rgb(213, 196, 161) rgb(204, 36, 29)";
          status_job = "rgb(250, 189, 47) rgb(60, 56, 54)";
          status_normal = "None rgb(40, 38, 37) / None None";
          status_italic = "rgb(211, 134, 155) rgb(40, 38, 37) Italic / None None";
          status_bold = "rgb(211, 134, 155) rgb(40, 38, 37) Bold / None None";
          status_code = "rgb(251, 241, 199) rgb(40, 38, 37) / None None";
          status_ellipsis = "rgb(251, 241, 199) rgb(40, 38, 37)  Bold / None None";
          purpose_normal = "None None";
          purpose_italic = "rgb(177, 98, 134) None Italic";
          purpose_bold = "rgb(177, 98, 134) None Bold";
          purpose_ellipsis = "None None";
          scrollbar_track = "rgb(80, 73, 69) None / rgb(50, 48, 47) None";
          scrollbar_thumb = "rgb(213, 196, 161) None / rgb(102, 92, 84) None";
          help_paragraph = "None None";
          help_bold = "rgb(214, 93, 14) None Bold";
          help_italic = "rgb(211, 134, 155) None Italic";
          help_code = "rgb(142, 192, 124) rgb(50, 48, 47)";
          help_headers = "rgb(254, 128, 25) None Bold";
          help_table_border = "rgb(80, 73, 69) None";
          preview_title = "rgb(235, 219, 178) rgb(40, 40, 40) / rgb(189, 174, 147) rgb(40, 40, 40)";
          preview = "rgb(235, 219, 178) rgb(40, 40, 40) / rgb(235, 219, 178) rgb(40, 40, 40)";
          preview_line_number = "rgb(124, 111, 100) None / rgb(124, 111, 100) rgb(40, 40, 40)";
          preview_separator = "rgb(70, 70, 80) None / rgb(60, 60, 60) None";
          preview_match = "None ansi(29) Bold";
          hex_null = "rgb(189, 174, 147) None";
          hex_ascii_graphic = "rgb(213, 196, 161) None";
          hex_ascii_whitespace = "rgb(152, 151, 26) None";
          hex_ascii_other = "rgb(254, 128, 25) None";
          hex_non_ascii = "rgb(214, 93, 14) None";
          staging_area_title = "rgb(235, 219, 178) rgb(40, 40, 40) / rgb(189, 174, 147) rgb(40, 40, 40)";
          mode_command_mark = "gray(5) ansi(204) Bold";
          good_to_bad_0 = "ansi(28)";
          good_to_bad_1 = "ansi(29)";
          good_to_bad_2 = "ansi(29)";
          good_to_bad_3 = "ansi(29)";
          good_to_bad_4 = "ansi(29)";
          good_to_bad_5 = "ansi(100)";
          good_to_bad_6 = "ansi(136)";
          good_to_bad_7 = "ansi(172)";
          good_to_bad_8 = "ansi(166)";
          good_to_bad_9 = "ansi(196)";
        }
        else {
          default = "rgb(101, 123, 131) none / rgb(147, 161, 161) none";
          tree = "rgb(147, 161, 161) none";
          file = "none none";
          directory = "rgb(38, 139, 210) none bold";
          exe = "rgb(211, 1, 2) none";
          link = "rgb(211, 54, 130) none";
          pruning = "rgb(147, 161, 161) none italic";
          perm__ = "rgb(147, 161, 161) none";
          perm_r = "none none";
          perm_w = "none none";
          perm_x = "none none";
          owner = "rgb(147, 161, 161) none";
          group = "rgb(147, 161, 161) none";
          sparse = "none none";
          git_branch = "rgb(88, 110, 117) none";
          git_insertions = "rgb(133, 153, 0) none";
          git_deletions = "rgb(211, 1, 2) none";
          git_status_current = "none none";
          git_status_modified = "rgb(181, 137, 0) none";
          git_status_new = "rgb(133, 153, 0) none";
          git_status_ignored = "rgb(147, 161, 161) none";
          git_status_conflicted = "rgb(211, 1, 2) none";
          git_status_other = "rgb(211, 1, 2) none";
          selected_line = "none rgb(238, 232, 213)";
          char_match = "rgb(133, 153, 0) none underlined";
          file_error = "rgb(203, 75, 22) none italic";
          flag_label = "none none";
          flag_value = "rgb(181, 137, 0) none bold";
          input = "none none";
          status_error = "rgb(203, 75, 22) rgb(238, 232, 213)";
          status_job = "rgb(108, 113, 196) rgb(238, 232, 213) bold";
          status_normal = "none rgb(238, 232, 213)";
          status_italic = "rgb(181, 137, 0) rgb(238, 232, 213)";
          status_bold = "rgb(88, 110, 117) rgb(238, 232, 213) bold";
          status_code = "rgb(108, 113, 196) rgb(238, 232, 213)";
          status_ellipsis = "none rgb(238, 232, 213)";
          scrollbar_track = "rgb(238, 232, 213) none";
          scrollbar_thumb = "none none";
          help_paragraph = "none none";
          help_bold = "rgb(88, 110, 117) none bold";
          help_italic = "rgb(88, 110, 117) none italic";
          help_code = "rgb(88, 110, 117) rgb(238, 232, 213)";
          help_headers = "rgb(181, 137, 0) none";
          help_table_border = "none none";
          preview_title = "rgb(147, 161, 161) rgb(238, 232, 213)";
          preview = "rgb(101, 123, 131) rgb(253, 246, 227) / rgb(147, 161, 161) rgb(238, 232, 213)";
          preview_line_number = "rgb(147, 161, 161) rgb(238, 232, 213)";
          preview_separator = "rgb(147, 161, 161) rgb(238, 232, 213)";
          preview_match = "None ansi(29)";
          staging_area_title = "gray(22) rgb(253, 246, 227)";
          good_to_bad_0 = "ansi(28)";
          good_to_bad_1 = "ansi(29)";
          good_to_bad_2 = "ansi(29)";
          good_to_bad_3 = "ansi(29)";
          good_to_bad_4 = "ansi(29)";
          good_to_bad_5 = "ansi(100)";
          good_to_bad_6 = "ansi(136)";
          good_to_bad_7 = "ansi(172)";
          good_to_bad_8 = "ansi(166)";
          good_to_bad_9 = "ansi(196)";
        };
    };
  };
}
