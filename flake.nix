{
  description = "Minimal NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # ==> EDIT THESE VALUES FOR YOUR OWN SETUP <==
      settings = {
        username = "lukasbt";
        userFullName = "Lukas Barragan Torres";
        userEmail = "lukas.barragantorres@ugent.be";

        gpg = {
          publicKeyLink = "https://keys.openpgp.org/vks/v1/by-fingerprint/7D7927AE9E9E61C7736EE6A8D78940BF1814BF2E";
          publicKeyHash = "98667971be2b8ff245c38922e94d14f83cbfbb5103b9313ae5bb668fb8634b06";
          keyId = "39FD4F630877B4D1";
        };

        hostname = "nixos";
        system = "x86_64-linux";
        timeZone = "Europe/Brussels";
        locale = "nl_BE.UTF-8";
        keyboardLayout = "be-latin1";
      };

    in
    {
      nixosConfigurations.${settings.hostname} = nixpkgs.lib.nixosSystem {
        system = settings.system;
        specialArgs = { inherit inputs settings; }; 
        modules = [
          ./hosts/laptop 
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit settings; };
              users.${settings.username} = import ./home;
            };
          }
        ];
      };
    };
}
