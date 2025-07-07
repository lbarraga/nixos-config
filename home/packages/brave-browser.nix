{ pkgs, ... }:

{
  
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "dhlnjfhjjbminbjbegeiijdakdkamjoi"; } # nord theme
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  };

}
