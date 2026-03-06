{ inputs, ... }:

{
  flake.modules.homeManager.hyprland-waybar = { osConfig, ... }: {
    programs.waybar = {
      enable = true;

      style =
        ./waybar/style.css; # Assuming you move style.css to a subfolder or update path

      settings = {
        mainBar = {
          layer = "top";
          output = osConfig.my.host.hyprland.primaryMonitor;
          position = "top";
          height = 1;

          modules-left = [ "custom/launcher" "hyprland/workspaces" ];
          modules-center = [ "clock#time" ];
          modules-right = [
            "custom/spotify"
            "custom/spotify-prev"
            "custom/spotify-play"
            "custom/spotify-next"
            "pulseaudio"
            "custom/pangolin"
            "tray"
            "battery"
          ];

          "custom/spotify" = {
            format = " {text}";
            exec = "~/.config/waybar/scripts/mediaplayer.sh";
            return-type = "json";
            interval = 1;
            signal = 1;
            exec-if = "playerctl -l | grep -q spotify";
            exec-on-event = true;
          };

          "custom/spotify-play" = {
            exec = "~/.config/waybar/scripts/play-pause.sh";
            return-type = "json";
            interval = 1;
            format = "{text}";
            on-click = "playerctl -p spotify play-pause";
            exec-if = "playerctl -l | grep -q spotify";
          };

          "custom/spotify-prev" = {
            exec = "~/.config/waybar/scripts/play-pause.sh";
            return-type = "json";
            interval = 1;
            format = "";
            on-click = "playerctl -p spotify previous; pkill -RTMIN+1 waybar";
            exec-if = "playerctl -l | grep -q spotify";
          };

          "custom/spotify-next" = {
            exec = "~/.config/waybar/scripts/play-pause.sh";
            return-type = "json";
            interval = 1;
            format = "";
            on-click = "playerctl -p spotify next; pkill -RTMIN+1 waybar";
            exec-if = "playerctl -l | grep -q spotify";
          };

          "custom/pangolin" = {
            format = "{}";
            exec = "~/.config/waybar/scripts/pangolin.sh";
            return-type = "json";
            interval = 5;
          };

          tray = {
            icon-size = 17;
            spacing = 10;
            show-passive-icons = true;
          };

          battery = {
            bat = "BAT0";
            interval = 10;
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            states = {
              warning = 15;
              critical = 5;
            };
            events = {
              on-discharging-warning = "notify-send -u normal 'Low Battery'";
              on-discharging-critical =
                "notify-send -u critical 'Very Low Battery'";
              on-charging-100 = "notify-send -u normal 'Battery Full!'";
            };
            format-icons = [ "" "" "" "" "" ];
            tooltip-format = "{time} remaining";
          };

          "clock#time" = {
            interval = 1;
            format = "  {:%H:%M} ";
            tooltip = true;
            tooltip-format = "<big>{:%A, %B %d, %Y}</big>";
          };

          "clock#date" = {
            interval = 10;
            format = " {:%e %b}";
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = " muted";
            scroll-step = 5;
            on-click = "pactl set-sink-mute 0 toggle";
            smooth-scrolling-threshold = 5.0;
            format-icons = {
              headphone = " ";
              hands-free = " ";
              headset = " ";
              default = [ "" " " " " ];
            };
          };

          temperature = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = [ "" ];
          };

          "custom/launcher" = {
            format = "<span size='15000' color='#d8dee9'> </span>";
            on-click = ''
              kitty sh -c "sudo nixos-rebuild switch --flake ~/nix-config#${osConfig.networking.hostName}; exec zsh"
            '';
          };
        };

        secondaryBars = {
          output = "!${osConfig.my.host.hyprland.primaryMonitor}";
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ ];
          modules-right = [ ];
          "hyprland/workspaces" = {
            all-outputs = false;
            format = "{id}";
            show-empty = true;

          };
        };
      };
    };
  };
}
