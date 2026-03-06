{ inputs, ... }:

{
  flake.modules.nixos.git = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.git ];
  };

  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "lukas.barragantorres@ugent.be";
          name = "Lukas Barragan Torres";
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
