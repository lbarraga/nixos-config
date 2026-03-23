{
  den.aspects.cli-tools = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        htop
        btop
        killall
        tree
        fastfetch
        unzip
        sops
        wl-clipboard
      ];

      programs.eza = {
        enable = true;
        git = true;
        icons = "auto";
        enableZshIntegration = true;
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
