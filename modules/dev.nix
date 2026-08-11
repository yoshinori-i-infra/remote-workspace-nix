# ======================================
# ~/.config/home-manager/module/dev.nix
# ======================================
{ config, pkgs, ... }:
let
  my = config.my.dotfilesDir;
in
{
  # 開発用パッケージ
  home.packages = with pkgs; [
    # shell
    zsh
    starship

    # CLI ユーティリティ
    jq
    ripgrep
    sheldon

    # 自作スクリプト
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # fzf の設定 (ripgrep と連携)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --glob '!.git'";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
 
  # Zshの設定ファイル
  home.file.".zshrc".source = 
    config.lib.file.mkOutOfStoreSymlink "${my}/.zshrc";

  # ===========================================
  # Direnv 設定
  # ===========================================
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
