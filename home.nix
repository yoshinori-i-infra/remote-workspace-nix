{ config, pkgs, lib, ... }:

{
  # ==========================================
  # 1. モジュールの読み込み
  # ==========================================
  imports = [
    ./modules/dev.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/nvim.nix
  ];

  # ==========================================
  # 独自のグローバル変数を定義
  # ==========================================
  options.my = {
    dotfilesDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/Documents/setting";
      description = "実体ドットファイルを配置しているディレクトリパス";
    };
  };

  # ==========================================
  # 3. 設定 (config)
  # ==========================================
  config = {
    home.username = "huslabo";
    home.homeDirectory = "/home/huslabo";
    home.stateVersion = "26.05";

    home.shellAliases = {
      ozsh = "exec env ZSH_THEME_MODE=omz zsh";
      szsh = "exec env ZSH_THEME_MODE=starship zsh";
    };

    programs.home-manager.enable = true;
  };
  
}
