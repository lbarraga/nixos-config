{ config, pkgs, settings, ... }:

let
  gpgKey = pkgs.fetchurl {
    url = settings.gpg.publicKeyLink;
    sha256 = settings.gpg.publicKeyHash;
  };
in
{
  home.packages = with pkgs; [
    gnupg
    pinentry-curses  # or gtk/qt depending on your DE
    yubikey-manager
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  programs.gpg = {
    enable = true;
  };

  # script that imports my gpg public key for use with git
  home.activation.importGPGKey = ''
    echo "Importing GPG key..."
    ${pkgs.gnupg}/bin/gpg --import ${gpgKey}
  '';

  programs.ssh.enable = true;
}
