{ inputs, ... }:

{
  flake.modules.homeManager.hyprland-hyprpaper = {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "~/.config/hypr/wallpaper.jpg" ];
        wallpaper = [ ",~/.config/hypr/wallpaper.jpg" ];
      };
    };
  };
}
