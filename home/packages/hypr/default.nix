{ pkgs, lib, ... }:

{

  imports =
    [ ./hyprland/hyprland.nix ./waybar/waybar.nix ./hyprpaper/hyprpaper.nix ];

  home.file.".config/hypr/hyprlock.conf".text =
    builtins.readFile ./hyprlock/hyprlock.conf;

  home.file.".config/hypr/wallpaper.jpg".source = ./hyprpaper/wallpaper.jpg;

  home.file.".config/waybar/scripts".source = ./waybar/scripts;
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
    nnn
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

