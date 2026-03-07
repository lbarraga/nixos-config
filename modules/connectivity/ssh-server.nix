{
  flake.modules.nixos.ssh-server = {

    # Enable the OpenSSH daemon
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
