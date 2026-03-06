{ inputs, ... }:

{
  flake.modules.nixos.lukas-desktop = {
    imports = with inputs.self.modules.nixos; [
      public-desktop

      lukasbt
      yubikey
      git
      ssh
      tailscale
      personal
      printing3d
    ];
  };
}
