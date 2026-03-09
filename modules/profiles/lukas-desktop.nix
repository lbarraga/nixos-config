{ inputs, ... }:

{
  flake.modules.nixos.lukas-desktop = {
    imports = with inputs.self.modules.nixos; [
      public-desktop

      lukasbt
      yubikey
      git
      embedded-dev
      ssh
      tailscale
      personal
      printing3d
    ];
  };
}
