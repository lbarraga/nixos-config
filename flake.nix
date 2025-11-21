{
  description = "Minimal NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      # ==> EDIT THESE VALUES FOR YOUR OWN SETUP <==
      settings = {
        username = "lukasbt";
        userFullName = "Lukas Barragan Torres";
        userEmail = "lukas.barragantorres@ugent.be";

        gpg = {
          publicKeyLink =
            "https://keys.openpgp.org/vks/v1/by-fingerprint/7D7927AE9E9E61C7736EE6A8D78940BF1814BF2E";
          publicKeyHash =
            "98667971be2b8ff245c38922e94d14f83cbfbb5103b9313ae5bb668fb8634b06";
          fingerprint = "7D7927AE9E9E61C7736EE6A8D78940BF1814BF2E";
          keyId = "39FD4F630877B4D1";
        };

        system = "x86_64-linux";
        timeZone = "Europe/Brussels";
        locale = "nl_BE.UTF-8";
      };

      mkSystem = hostname:
        let
          unstable_pkgs = import nixpkgs-unstable {
            system = settings.system;
            config.allowUnfree = true;
          };
        in nixpkgs.lib.nixosSystem {
          system = settings.system;
          specialArgs = {
            inputs = inputs;
            settings = settings;
            unstable_pkgs = unstable_pkgs;
          };
          modules = [
            ./hosts/${hostname}
            ./nixos/modules/options.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  settings = settings;
                  nixosConfig = self.nixosConfigurations.${hostname}.config;
                  unstable_pkgs = unstable_pkgs;
                };
                users.${settings.username} = import ./home;
              };
            }
          ];
        };

    in {
      nixosConfigurations = {
        desktop = mkSystem "desktop";
        laptop = mkSystem "laptop";
      };
    };
}
