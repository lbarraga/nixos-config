{
  den.aspects.nh = {user, ...}: {
    nixos = {
      programs.nh = {
        enable = true;
        flake = "/home/${user.userName}/nix-config";
      };
    };
  };
}
