{ inputs, ... }:

{
  flake.modules.nixos.public-desktop = {
    # This is the generic bundle anyone on GitHub could use.
    imports = with inputs.self.modules.nixos; [
      core
      hyprland
      cli-tools
      shell
      fonts
      udisks
      brave-browser
      office
      system-tray
      bluetooth
      printing
      sound
      nvim
    ];
  };
}
