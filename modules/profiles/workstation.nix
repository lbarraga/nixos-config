{den, ...}: {
  den.aspects.workstation = {
    includes = with den.aspects; [
      # Common System / Hardware
      core
      gnome
      udisks
      bluetooth
      printing
      sound
      tailscale
      yubikey

      # Common GUI Apps
      fonts
      brave-browser
      office
      system-tray
      personal
      printing3d
      cli-tools
      git
      nvim
      zsh
      nh
    ];
  };
}
