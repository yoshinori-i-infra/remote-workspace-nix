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

  # fzf の設定 (ripgrep と連携)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --glob '!.git'";
  };

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

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
