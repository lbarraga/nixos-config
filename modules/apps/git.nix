{
  den.aspects.git = {
    homeManager.programs.git = {
      enable = true;
      settings = {
        user = {
          email = "lukas.barragantorres@ugent.be";
          name = "Lukas Barragan Torres";
        };
        alias = {
          ac = "!git add . && git commit -m";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
      signing = {
        key = "39FD4F630877B4D1";
        signByDefault = true;
      };
    };
  };
}
