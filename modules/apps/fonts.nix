{ inputs, ... }:

{
  flake.modules.nixos.fonts = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.fonts ];
  };

  flake.modules.homeManager.fonts = { pkgs, ... }: {
    home.packages = with pkgs; [ font-awesome nerd-fonts.jetbrains-mono ];
  };
}
