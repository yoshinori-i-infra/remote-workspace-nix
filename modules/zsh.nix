{ config, pkgs,  ... }:

let
  my = config.my.dotfilesDir;
in
{
  home.packages = with pkgs; [
    zsh
  ];

  # ~/.zshrc に、指定したディレクトリにある実体ファイルへのシンボリックリンクを張る
  home.file.".zshrc".source = 
    config.lib.file.mkOutOfStoreSymlink "${my}/.zshrc";

}
