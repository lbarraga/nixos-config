{ settings, ... }: {

  programs.git = {
    enable = true;
    userName = settings.userFullName;
    userEmail = settings.userEmail;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    signing = {
      key = settings.gpg.keyId;
      signByDefault = true;
    };
  };

}
