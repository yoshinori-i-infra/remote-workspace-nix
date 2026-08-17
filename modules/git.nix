{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    userName = "yoshinori-i-infra";
    userEmail = "y.imada.dev@gmail.com";
  };
  
}
