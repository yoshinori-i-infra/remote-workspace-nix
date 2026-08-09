{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      ",g" = "git";
      ",go" = "nix shell nixpkgs#go";
      ",deno" = "nix shell nixpkgs#deno";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # [.zshrc の最先頭] Powerlevel10k Instant Prompt
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    # [.zshrc の末尾] 設定読み込み
    initContent = lib.mkBefore ''
      # --- Powerlevel10k 設定の読み込み ---
      [ -f "$HOME/Documents/setting/p10k.zsh" ] && source "$HOME/Documents/setting/p10k.zsh"
      [ -f "$HOME/.p10k.zsh" ] && source "$HOME/.p10k.zsh"

      # --- 履歴ファイル ---
      export HISTFILE="$HOME/Documents/setting/.zsh_history"

      # --- 補完システム ---
      autoload -U compinit && compinit
      zstyle ':completion:*' format '%F{green}%d%f'
      zstyle ':completion:*' group-name ""

      # --- 自作設定ファイルの自動読み込み ---
      SETTING_DIR="$HOME/Documents/setting"
      [ -f "$SETTING_DIR/env_vars.sh" ] && source "$SETTING_DIR/env_vars.sh"
      [ -f "$SETTING_DIR/aliases.sh" ] && source "$SETTING_DIR/aliases.sh"
      [ -f "$SETTING_DIR/functions.sh" ] && source "$SETTING_DIR/functions.sh"

      # --- 環境変数設定 ---
      unset SSH_ASKPASS
      export DIRENV_LOG_FORMAT=""
      [[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
    '';
  };
}
