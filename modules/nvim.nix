# ===========================================
# ~/.config/home-magager/module/nvim.nix
# ===========================================
{ config, pkgs, ... }:
let
  my = config.my.dotfilesDir;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    plugins = [];
    
    initLua = ''
      dofile("${my}/nvim/init.lua")
    '';

  };
  home.packages = with pkgs; [
    nil
    nixfmt
  ];

  home.file.".vimrc".source = 
    config.lib.file.mkOutOfStoreSymlink "${my}/vimrc";
}
