{ settings, config, ... }: {
  networking.hostName = config.my.host.hostname;
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";

  time.timeZone = settings.timeZone;

  i18n.defaultLocale = settings.locale;
}
