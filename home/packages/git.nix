{ config, pkgs, ... }:
{

  programs.git = {
    enable = true;
    userName = "Lukas Barragan Torres";
    userEmail = "lukas@barragantorres@ugent.be";

    extraConfig = {
      init.defaultBranch = "main";
    };

    signing = {
      key = "39FD4F630877B4D1";
      signByDefault = true;
    };
  };

}
