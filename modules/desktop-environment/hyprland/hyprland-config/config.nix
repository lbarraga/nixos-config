{
  flake.modules.homeManager.hyprland-config = { osConfig, lib, ... }: {
    wayland.windowManager.hyprland = let
      # 1. Grab the definitions from the OS config
      hostMonitors = osConfig.my.host.hyprland.monitors;
      ws = osConfig.my.host.hyprland.workspaces;

      # 2. Logic for custom, monitor-bound workspaces
      mkWorkspaceEntry = monitor: w:
        "${toString w}, monitor:${monitor}, persistent=true";

      customWorkspaces = builtins.concatMap
        (monitor: map (w: mkWorkspaceEntry monitor w) ws.${monitor})
        (builtins.attrNames ws);

      # 3. Logic for the fallback: Persistent workspaces 1-10 (unbound to specific hardware)
      fallbackWorkspaces =
        map (w: "${toString w}, persistent=true") (lib.range 1 10);

      # 4. Check if custom configurations were provided
      hasCustomWorkspaces = ws != { };
      hasCustomMonitors = hostMonitors != [ ];

    in {
      enable = true;

      settings = {

        # If monitors are defined, use them. Otherwise, use a generic catch-all.
        monitor =
          if hasCustomMonitors then hostMonitors else [ ",preferred,auto,1" ];

        # If the user defines custom workspaces, use those. 
        # Otherwise, inject the fallback workspaces (1 to 10).
        workspace =
          if hasCustomWorkspaces then customWorkspaces else fallbackWorkspaces;

        ###################
        ### MY PROGRAMS ###
        ###################
        "$terminal" = "kitty";
        "$fileManager" = "nnn";
        "$menu" = "pkill rofi || rofi -show drun";
        "$nix-menu" = "pkill rofi || nix-run-app";
        "$prev_song" = "playerctl -p spotify previous";
        "$next_song" = "playerctl -p spotify next";
        "$pauze_song" = "playerctl -p spotify play-pause";

        #################
        ### AUTOSTART###
        #################
        "exec-once" = [
          "hyprpaper"
          "waybar"
          "swaync"
          "blueman-applet" # start bluetooth icon in tray
          "nm-applet" # network manager applet icon in tray
          "QT_STYLE_OVERRIDE=Fusion QT_QPA_PLATFORM=xcb synology-drive autostart" # synology drive quirck
          "udiskie -t"
          "fcitx5 -d"
        ];

        #############################
        ### ENVIRONMENT VARIABLES ###
        #############################
        env = [ "HYPRCURSOR_THEME,Adwaita" "HYPRCURSOR_SIZE,24" ];

        debug = { disable_logs = false; };

        #####################
        ### LOOK AND FEEL ###
        #####################
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(d8dee9aa)";
          "col.inactive_border" = "rgba(434c5eaa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, slide"
            "workspacesOut, 1, 1.94, almostLinear, slide"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = { new_status = "master"; };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        #############
        ### INPUT ###
        #############
        input = {
          kb_layout = "${osConfig.my.host.hyprland.keyboardLayout}";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 1;
          sensitivity = 0;
          touchpad = { natural_scroll = true; };
          numlock_by_default = true;
        };

        "gesture" = "3, horizontal, workspace";

        device = [{
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }];

        ###################
        ### KEYBINDINGS ###
        ###################
        "$mainMod" = "SUPER";

        bind = [
          "$mainMod, T, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"
          "$mainMod, N, exec, $next_song"
          "$mainMod, B, exec, $prev_song"
          "$mainMod, H, exec, $pauze_song"
          "$mainMod, F, fullscreen"

          ", PRINT, exec, hyprshot -m region -o ~/Pictures/Screenshots"
          "shift, PRINT, exec, hyprshot -m window -o ~/Pictures/Screenshots"
          "$SUPER_SHIFT, l, exec, hyprlock"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Switch to workspace
          "$mainMod, code:10, workspace, 1"
          "$mainMod, code:11, workspace, 2"
          "$mainMod, code:12, workspace, 3"
          "$mainMod, code:13, workspace, 4"
          "$mainMod, code:14, workspace, 5"
          "$mainMod, code:15, workspace, 6"
          "$mainMod, code:16, workspace, 7"
          "$mainMod, code:17, workspace, 8"
          "$mainMod, code:18, workspace, 9"
          "$mainMod, code:19, workspace, 10"

          "$mainMod CTRL, left, workspace, r-1"
          "$mainMod CTRL, right, workspace, r+1"

          # Move focused window to workspace
          "$mainMod SHIFT, code:10, movetoworkspace, 1"
          "$mainMod SHIFT, code:11, movetoworkspace, 2"
          "$mainMod SHIFT, code:12, movetoworkspace, 3"
          "$mainMod SHIFT, code:13, movetoworkspace, 4"
          "$mainMod SHIFT, code:14, movetoworkspace, 5"
          "$mainMod SHIFT, code:15, movetoworkspace, 6"
          "$mainMod SHIFT, code:16, movetoworkspace, 7"
          "$mainMod SHIFT, code:17, movetoworkspace, 8"
          "$mainMod SHIFT, code:18, movetoworkspace, 9"
          "$mainMod SHIFT, code:19, movetoworkspace, 10"

          # Special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          "$mainMod, SPACE, exec, $menu"
          "$mainMod ALT, SPACE, exec, $nix-menu"
        ];

        bindr = [ ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Laptop multimedia keys
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];

        # Playerctl binds
        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
      };
    };
  };
}
