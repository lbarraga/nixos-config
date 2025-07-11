{ config, pkgs, ... }:

{
  imports = [
    ./python.nix
    ./lua.nix
  ];
}

