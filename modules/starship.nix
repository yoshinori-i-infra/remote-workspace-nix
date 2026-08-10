# ====================================================
# ~/.config/home-manager/modules/starship.nix
# ====================================================
{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = false;

    settings = {
      add_newline = true;

      # 2行プロンプトのレイアウト定義
      format = ''
        [╭─](bold blue)$os$directory$git_branch$git_status
        [╰─](bold blue)$character
      '';

      # 入力記号
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✗](bold red)";
      };

      # OSアイコン（FedoraとMacで自動切り替え）
      os = {
        disabled = false;
        symbols = {
          Fedora = "🎩 ";
          Macos = "🍎 ";
        };
      };

      # ディレクトリ表示
      directory = {
        style = "bold cyan";
        read_only = " 🔒";
        truncation_length = 3;
      };

      # Gitブランチ
      git_branch = {
        symbol = "🌱 ";
        style = "bold purple";
      };
    };
  };
}

