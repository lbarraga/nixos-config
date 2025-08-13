{ pkgs, lib, ... }:

{
  home.file.".config/hypr/hyprland.conf".text =
    builtins.readFile ./hyprland/hyprland.conf;

  home.file.".config/hypr/hyprlock.conf".text =
    builtins.readFile ./hyprlock/hyprlock.conf;

  home.file.".config/hypr/hyprpaper.conf".text =
    builtins.readFile ./hyprpaper/hyprpaper.conf;
  home.file.".config/hypr/wallpaper.jpg".source = ./hyprpaper/wallpaper.jpg;

  home.file.".config/waybar".source = ./waybar;
  home.activation.makeWaybarScriptsExecutable =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      find ${./waybar} -type f -name '*.sh' -exec chmod +x {} \;
    '';

  home.file.".config/wofi".source = ./wofi;
  home.file.".config/kitty".source = ./kitty;

  # Install needed packages
  home.packages = with pkgs; [
    hyprland
    kitty
    nautilus
    wofi
    hyprpaper
    hyprlock
    waybar
    swaynotificationcenter
    libnotify
    hyprshot
    hyprlock
    hyprcursor
    playerctl
    brightnessctl
  ];
}

