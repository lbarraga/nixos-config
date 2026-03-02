{
  imports = [
    ./settings.nix
    ./packages/common.nix
    ./packages/git.nix
    ./packages/eza.nix
    ./packages/direnv.nix
    ./packages/brave-browser.nix
    ./packages/nvim/nvim.nix
    ./packages/ssh.nix
    ./packages/gpg.nix
    ./packages/fonts.nix
    ./packages/shell/zsh.nix
    ./packages/shell/starship.nix
    ./packages/xdg.nix
    ./packages/hypr
    ./packages/dev
  ];
}

