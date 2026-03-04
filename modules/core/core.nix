{ inputs, lib, ... }:

{
  # Define the architectures your flake supports
  systems = [ "x86_64-linux" ];

  imports = [ inputs.flake-parts.flakeModules.modules ];

  flake.lib = {

    # The mkNixos helper function as described in the Dendritic guide
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        # Pass inputs to all NixOS modules so they can access inputs.self.modules
        specialArgs = { inherit inputs; };

        modules = [
          # 1. The top-level feature module for the specific host
          inputs.self.modules.nixos.${name}

          # 2. Set the host platform unconditionally
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
          }

          # 3. Inject global framework modules so they are available in all NixOS contexts
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
        ];
      };
    };

  };
}
