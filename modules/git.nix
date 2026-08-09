{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    settings = {
      user = {
	userName = "huslabo";
      	userEmail = "dchaozsh@gmail.com";
      };
    };
  };
  
}
