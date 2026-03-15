{
  den.aspects.personal = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        spotify
        discord
        obsidian
        synology-drive-client
        anki
      ];
    };
  };
}
