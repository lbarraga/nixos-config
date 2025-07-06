{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python313
    uv
  ];

  home.sessionVariables = {
    UV_PYTHON_DOWNLOADS = "never"; # let nix manage python versions
  };
}
