{ config, pkgs, ... }:

let
  my = config.my.dotfilesDir;
in
{
  # 開発用パッケージ
  home.packages = with pkgs; [
    # shell
    zsh

    # Go
    go
    gopls
    delve
    golangci-lint
    goreleaser

    # Rust
    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer

    # Deno
    deno

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

  # ===========================================
  # 環境変数・PATH 設定
  # ===========================================
  # 環境変数
  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    NIX_REMOTE = "daemon";
  };

  # PATH 追加
  home.sessionPath = [
    "$HOME/.juliaup/bin"
    "$HOME/.local/bin"
    "${config.home.homeDirectory}/go/bin"
  ];
  
  # Zshの設定ファイル
  home.file.".zshrc".source = 
    config.lib.file.mkOutOfStoreSymlink "${my}/.zshrc";

  # ===========================================
  # Direnv 設定
  # ===========================================
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
