{ inputs, ... }:

{
  flake.modules.nixos.yubikey = {
    services.pcscd.enable = true; # Smartcard daemon

    home-manager.sharedModules = [ inputs.self.modules.homeManager.yubikey ];
  };

  flake.modules.homeManager.yubikey = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnupg
      pinentry-curses
      yubikey-manager
      yubioath-flutter
    ];

    # Enable GPG and the GPG Agent with SSH support
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    # Script to import your GPG public key and set ultimate trust
    # (Assuming you define your keys in your Constants Aspect or hardcode them here)
    home.activation.importGPGKey = ''
      echo "Importing GPG key..."
      ${pkgs.gnupg}/bin/gpg --import ${
        pkgs.fetchurl {
          url =
            "https://keys.openpgp.org/vks/v1/by-fingerprint/7D7927AE9E9E61C7736EE6A8D78940BF1814BF2E";
          sha256 =
            "98667971be2b8ff245c38922e94d14f83cbfbb5103b9313ae5bb668fb8634b06";
        }
      }

      echo "Setting ultimate trust..."
      echo "7D7927AE9E9E61C7736EE6A8D78940BF1814BF2E:6:" | ${pkgs.gnupg}/bin/gpg --import-ownertrust
    '';
  };
}
