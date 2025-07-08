{ pkgs, settings, ... }:

{
  programs.hyprland.enable = true;

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  environment.systemPackages = [ pkgs.wl-clipboard ];

  # Required for Wayland apps to work correctly
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # workaround for some GPUs
  };

  # greetd auto-login (lightweight DM alternative)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = settings.username; 
      };
    };
  };

  services.xserver.enable = false;
}

