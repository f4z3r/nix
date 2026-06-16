{...}: {
  programs = {
    mise = {
      enable = true;
      globalConfig = {
        settings = {
          all_compile = false;
        };
      };
    };
  };
}
