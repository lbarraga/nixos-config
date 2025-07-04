{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "be";
    variant = "nodeadkeys";
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "lukasbt";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
