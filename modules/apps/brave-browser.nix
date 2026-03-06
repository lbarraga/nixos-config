{ inputs, ... }:

{
  flake.modules.nixos.brave-browser = {
    home-manager.sharedModules =
      [ inputs.self.modules.homeManager.brave-browser ];
  };

  flake.modules.homeManager.brave-browser = { pkgs, ... }: {
    programs.brave = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "dhlnjfhjjbminbjbegeiijdakdkamjoi"; } # nord theme
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
        { id = "hjfkenebldkfgibelglepinlabpjfbll"; } # no youtube shorts
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # Youtube sponsor block
      ];
      commandLineArgs =
        [ "--disable-features=WebRtcAllowInputVolumeAdjustment" ];
    };
  };
}
