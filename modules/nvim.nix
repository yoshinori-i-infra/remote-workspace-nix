# ===========================================
# ~/.config/home-magager/module/nvim.nix
# ===========================================
{ config, pkgs, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/Documents/setting";
in
{
  # Neovim 本体のインストール
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = "";
  };

  xdg.configFile."nvim".source = 
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";

  home.file.".vimrc".source = 
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.vimrc";
}
