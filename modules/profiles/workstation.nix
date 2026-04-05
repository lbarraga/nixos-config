{den, ...}: {
  den.aspects.workstation = {
    includes = with den.aspects; [
      # boot
      boot-uefi

      # Common System / Hardware
      core
      theming
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
