{ pkgs, ... }:

{
  
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "dhlnjfhjjbminbjbegeiijdakdkamjoi"; } # nord theme
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "hjfkenebldkfgibelglepinlabpjfbll"; } # no youtube shorts
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  };

}
