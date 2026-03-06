{ inputs, lib, ... }:

{
  flake.modules.nixos.hyprland = { config, pkgs, ... }: {

    options.my.host = {
      defaultUser = lib.mkOption {
        type = lib.types.str;
        description = "The user to automatically log in via greetd.";
      };
      hyprland = {
        keyboardLayout = lib.mkOption { type = lib.types.str; };
        primaryMonitor = lib.mkOption { type = lib.types.str; };
        monitors = lib.mkOption { type = lib.types.listOf lib.types.str; };
        workspaces = lib.mkOption {
          type = lib.types.attrsOf (lib.types.listOf lib.types.int);
        };
      };
    };

    config = {
      programs.hyprland.enable = true;

      environment.variables = {
        XCURSOR_THEME = "Adwaita";
        XCURSOR_SIZE = "24";
      };

      environment.systemPackages =
        [ pkgs.wl-clipboard pkgs.adwaita-icon-theme ];

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
            user = config.my.host.defaultUser;
          };
        };
      };

      services.xserver.enable = false;

      # Inject the HM configuration for any user on this host
      home-manager.sharedModules = [ inputs.self.modules.homeManager.hyprland ];
    };
  };

  flake.modules.homeManager.hyprland = { pkgs, lib, ... }:
    let
      # Create a derivation that includes your script and its dependencies
      nix-run-script = pkgs.writeShellApplication {
        name = "nix-run-app";
        text = builtins.readFile ./scripts/nix-launcher.sh;
      };
    in {
      imports = with inputs.self.modules.homeManager; [
        hyprland-config
        hyprland-waybar
        hyprland-hyprpaper
      ];

      home.file.".config/hypr/hyprlock.conf".text =
        builtins.readFile ./hyprlock.conf;

      home.file.".config/hypr/wallpaper.jpg".source = ./wallpaper.jpg;

      home.file.".config/waybar/scripts".source = ./scripts;
      home.activation.makeWaybarScriptsExecutable =
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          find ${./scripts} -type f -name '*.sh' -exec chmod +x {} \;
        '';

      home.file.".config/rofi".source = ./rofi;
      home.file.".config/kitty".source = ./kitty;

      # Install needed packages
      home.packages = with pkgs; [
        hyprland
        kitty
        rofi
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
        nix-run-script
      ];
    };
}
