{
  den.aspects.fonts = {
    nixos =
      { pkgs, ... }:
      {
        fonts.packages = with pkgs; [
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          font-awesome
          nerd-fonts.jetbrains-mono
        ];

        fonts.enableDefaultPackages = true;
      };
  };
}
