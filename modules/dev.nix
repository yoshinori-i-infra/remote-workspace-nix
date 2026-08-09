{ config, pkgs, ... }:

{
  # 開発用パッケージ
  home.packages = with pkgs; [
    # Go
    go
    gopls
    delve
    golangci-lint
    goreleaser

    # Deno
    deno

    # CLI ユーティリティ
    jq
    ripgrep

    # 自作スクリプト
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # 環境変数
  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    EDITOR = "vim";
  };

  # PATH 追加
  home.sessionPath = [
    "$HOME/.juliaup/bin"
    "$HOME/.local/bin"
    "${config.home.homeDirectory}/go/bin"
  ];

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
