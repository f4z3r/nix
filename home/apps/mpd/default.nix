{
  pkgs,
  username,
  ...
}: {
  programs.ncmpcpp = {
    enable = true;
    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "ctrl-j";
        command = [
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
        ];
      }
      {
        key = "n";
        command = "scroll_down";
      }
      {
        key = "ctrl-n";
        command = [
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
          "scroll_down"
        ];
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "ctrl-k";
        command = [
          "scroll_up"
          "scroll_up"
          "scroll_up"
          "scroll_up"
          "scroll_up"
          "scroll_up"
          "scroll_up"
          "scroll_up"
          "scroll_up"
          "scroll_up"
        ];
      }
      {
        key = "l";
        command = "next_column";
      }
      {
        key = "h";
        command = "previous_column";
      }
      {
        key = "H";
        command = [
          ''push_characters "/."''
          ''push_character "enter"''
          "select_found_items"
        ];
      }
    ];
  };

  services.mpd = {
    enable = true;
    musicDirectory = /home/${username}/Music;
    network.startWhenNeeded = true;
    extraConfig = ''
      volume_normalization "yes"
      audio_output {
         type          "alsa"
         name          "ALSA Device"
         mixer_control "Master"
      }
    '';
  };
}
