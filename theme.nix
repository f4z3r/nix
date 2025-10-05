{theme, ...}:
if theme == "dark"
then {
  theme = "dark";
  foreground = "#d4be98";
  background = "#282828";
  background-alt = "#32302f";
  current_line = "#d4be98";
  selection = "#928374";
  comment = "#665c54";
  cyan = "#89b482";
  green = "#a9b665";
  orange = "#e78a4e";
  magenta = "#d3869b";
  blue = "#7daea3";
  red = "#ea6962";
  aqua = "#89b482";
  purple = "#d3869b";
}
else {
  theme = "light";
  foreground = "#654735";
  background = "#fbf1c7";
  background-alt = "#f2e5bc";
  current_line = "#654735";
  selection = "#928374";
  comment = "#d5c4a1";
  cyan = "#4c7a5d";
  green = "#6c782e";
  orange = "#c35e0a";
  magenta = "#945e80";
  blue = "#45707a";
  red = "#c14a4a";
  aqua = "#4c7a5d";
  purple = "#945e80";
}
