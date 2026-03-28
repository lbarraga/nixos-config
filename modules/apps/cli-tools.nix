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
      ];

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
