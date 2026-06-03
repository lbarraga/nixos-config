{inputs, ...}: {
  den.aspects.nvim = {
    homeManager = {pkgs, ...}: {
      home.packages = [
        inputs.my-neovim.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
