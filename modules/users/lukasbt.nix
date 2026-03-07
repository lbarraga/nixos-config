{ inputs, ... }:

{
  flake.modules.nixos.lukasbt = {
    users.users.lukasbt = {
      isNormalUser = true;
      description = "Lukas Barragan Torres";
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
        "plugdev"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJUplULk1eE/aa8bxs+t4kq2IG0V7jbonqn6GqakZk+iYisqEri61jE08Dj6s8XNoviC7U5d62bykCUe6EDaNCSRXE7DYeZ2dRO10zuHpzj7MYhvEFPAwV+2TrOQXabFcWHHjX5nrxp47TAbCtcMEsybz0RKJRhaMu3oNGSzMII4HBcNPuVmjl1G/Ph6+gHC2tSmAXwvckD0HuwonYtOYBKHy+GyuKfeXNEiafn3H7nfJMJKJUmBP2hZpDCNtnmrNq/W3+3SKOIwe08LPGNDOBMijsGPCjiRFM5+adDRTBm5TKnIDsW2uxrt0+rfU5QK5RT1vuOA+/1DIlmR67pgkUuBI53w9XOpLLIA5yt+tUoj1/fCF4eust9IXRIDki7aBf8YM5KnZY37VvVcEdyYOmtFphKEYYwVzePZNCJyzBMFwa/AIEcvliwYRu1xNF5QP70bennUEPXb1HcUnbEqT6706ceyRaVarXhBvxkPN1f/eewQoetq6QqK/ZwvtizltZe/vlWwXQWFshwoZBVyHZC2Sv7lYO63F+c738CdbXWK/B6u01+sS/Dt1JgxlX5MFNnnk1ZkAHqkm8mkzrlG8AWiZukD9H+5zI4AjsRTX7qblc2bYJAa/TBMD4G95DTOKQqGSPNFUvwB7aYI0EVXvVWy3eFC3pxX5MIQLqhME9ZQ== cardno:26_291_740"
      ];
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";

      users.lukasbt = {
        imports = [ inputs.self.modules.homeManager.lukasbt ];
      };
    };
  };

  flake.modules.homeManager.lukasbt = {
    home.username = "lukasbt";
    home.homeDirectory = "/home/lukasbt";

    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
  };
}
