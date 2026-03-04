{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [ qt6Packages.fcitx5-chinese-addons fcitx5-gtk ];
      waylandFrontend = true;
    };
  };

  environment.variables = {
    XMODIFIERS = "@im=fcitx"; # needed for XWayland apps
  };

}
