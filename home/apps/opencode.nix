{lib, ...}: {
  programs.opencode = {
    enable = true;
    settings = {
      theme = "gruvbox";
      default_agent = "plan";
      # model = "google/gemini-3.1-pro";
      autoshare = false;
      autoupdate = false;
      permission = {
        "*" = "ask";
        bash = {
          "*" = "ask";
          "git diff" = "allow";
          "git log*" = "allow";
          "grep *" = "allow";
        };
        edit = "ask";
        read = "allow";
        glob = "allow";
        grep = "allow";
        list = "allow";
        task = "allow";
        skill = "allow";
        lsp = "allow";
        todowrite = "allow";
        webfetch = "ask";
        websearch = "allow";
        codesearch = "allow";
        external_directory = "ask";
      };
    };
  };
}
