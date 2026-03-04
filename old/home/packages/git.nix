{ settings, ... }: {

  programs.git = {
    enable = true;
    settings = {

      user = {
        email = settings.userEmail;
        name = settings.userFullName;
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    signing = {
      key = settings.gpg.keyId;
      signByDefault = true;
    };
  };

}
