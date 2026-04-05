{
  den.aspects.minecraft-server = {
    nixos = {
      services.minecraft-server = {
        enable = true;
        eula = true;
        openFirewall = true;

        # This tells NixOS to lock down the config and generate it natively
        declarative = true;

        # The native way to map users to UUIDs for the whitelist
        whitelist = {
          "lukasbt" = "63ca895d-6a59-40af-9939-0ed308f4c219";
          "Charlotte5359" = "622e2604-c1c1-4ab1-b52e-c703213e7f9c";
          "Arne03" = "9e76805c-24ab-4738-9b33-2c3812d61622";
        };

        serverProperties = {
          difficulty = "easy";
          gamemode = "survival";
          motd = "Huisje van Charlotte, Lukas en Arne";
          max-players = 20;
          white-list = true;
          enforce-whitelist = true;
          "pause-when-empty-seconds" = 60;
        };
      };
    };
  };
}
