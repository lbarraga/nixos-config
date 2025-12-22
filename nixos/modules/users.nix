{ pkgs, settings, options, ... }:

{

  programs.zsh.enable = true;

  # This allows unpatched downloaded binaries to be run (i think)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = options.programs.nix-ld.libraries.default;

  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.userFullName;
    extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" ];
    shell = pkgs.zsh;
  };

  security = {
    sudo.wheelNeedsPassword = true;
    pam.services.hyprlock = { };
  };
}
