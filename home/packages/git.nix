{ config, pkgs, settings, ... }:
{

  programs.git = {
    enable = true;
    userName = settings.userFullName;
    userEmail = settings.userEmail;

    extraConfig = {
      init.defaultBranch = "main";
    };

    signing = {
      key = settings.gitGpgKeyId;
      signByDefault = true;
    };
  };

}
