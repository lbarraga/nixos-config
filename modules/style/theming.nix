{inputs, ...}: {
  den.aspects.theming = {
    nixos = {pkgs, ...}: {
      imports = [inputs.stylix.nixosModules.stylix];

      stylix.enable = true;
      stylix.image = ./wallpaper.jpg;
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      stylix.fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        sansSerif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          applications = 11;
          terminal = 11;
          desktop = 11;
          popups = 11;
        };
      };
    };

    homeManager = {
      stylix.targets.neovim.enable = false; # i manage ny own nvim
    };
  };
}
