{ settings, ... }: {
  networking.hostName = settings.hostname;
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";

  time.timeZone = settings.timeZone;

  i18n.defaultLocale = settings.locale;

  console.keyMap = settings.keyboardLayout;
}
