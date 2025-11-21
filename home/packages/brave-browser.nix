{ unstable_pkgs, ... }:

{

  programs.chromium = {
    enable = true;
    package = unstable_pkgs.brave;
    extensions = [
      { id = "dhlnjfhjjbminbjbegeiijdakdkamjoi"; } # nord theme
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "hjfkenebldkfgibelglepinlabpjfbll"; } # no youtube shorts
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # Youtube sponsor block
    ];
    commandLineArgs = [ "--disable-features=WebRtcAllowInputVolumeAdjustment" ];
  };

}
