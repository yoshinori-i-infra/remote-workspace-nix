{ config, pkgs, ... }:

{
  imports = [
    ./modules/dev.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/nvim.nix
  ];

  home.username = "huslabo";
  home.homeDirectory = "/home/huslabo";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
