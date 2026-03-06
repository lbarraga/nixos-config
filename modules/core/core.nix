{ inputs, ... }:

{
  flake.modules.nixos.core = { config, ... }: {

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking basics (hostname is defined in the specific host feature)
    networking.networkmanager.enable = true;
    services.resolved.enable = true;

    # Nix and System settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.05";

    # Time and Locale
    time.timeZone = "Europe/Brussels";
    i18n.defaultLocale = "nl_BE.UTF-8";

    # SOPS Configuration
    sops = {
      age.keyFile = "/var/lib/sops-nix/key.txt";

      # Dynamically point to the host's secrets.yaml using inputs.self (the root of the flake)
      # This relies on config.networking.hostName being set in the host module (e.g., desktop.nix)
      defaultSopsFile =
        "${inputs.self}/modules/hosts/${config.networking.hostName}/secrets.yaml";
      defaultSopsFormat = "yaml";
    };

  };
}
