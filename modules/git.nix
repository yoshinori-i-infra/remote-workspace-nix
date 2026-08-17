{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "yoshinori-i-infra";
        email = "48372228+Yoshinori-Imada@users.noreply.github.com";
      };
      credential."https://github.com" = {
        helper = "!gh auth git-credential";
      };
      credential."https://gist.github.com" = {
        helper = "!gh auth git-credential";
      };
    };
  };
  
}
