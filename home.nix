{ config, pkgs, ... }:

{
  home.username = "hustea";
  home.homeDirectory = "/home/hustea";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    jq
    ripgrep

    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # --- 2. PATH 追加 ---
  home.sessionPath = [
    "$HOME/.juliaup/bin"
    "$HOME/.local/bin"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # アプリケーションごとの詳細設定（zsh, git, tmux など）
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

    # [.zshrc の末尾] 元の設定をそのまま完全再現
    initExtra = ''
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


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hustea/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
