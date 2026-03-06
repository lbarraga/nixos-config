{ inputs, ... }:

{
  flake.modules.nixos.cli-tools = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.cli-tools ];
  };

  flake.modules.homeManager.cli-tools = { pkgs, ... }: {
    home.packages = with pkgs; [ htop btop killall tree fastfetch unzip sops ];

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
}
