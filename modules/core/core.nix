{
  flake.modules.nixos.core =
    { config, options, ... }:
    {

      # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Networking basics (hostname is defined in the specific host feature)
      networking.networkmanager.enable = true;
      services.resolved.enable = true;

      # Nix and System settings
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "25.05";

      programs.nix-ld = {
        enable = true;
        libraries = options.programs.nix-ld.libraries.default;
      };

      # Time and Locale
      time.timeZone = "Europe/Brussels";
      i18n.defaultLocale = "nl_BE.UTF-8";
    };
}
