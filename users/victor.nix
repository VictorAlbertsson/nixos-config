{ config, lib, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.victor = {
    xdg.userDirs.enable = true;
    home.homeDirectory = "/home/victor";
    home.keyboard.layout = "us";
    home.packages = with pkgs; [
      vim
      tree
      firefox
      ((emacsPackagesFor emacs).emacsWithPackages (epkgs: with epkgs.melpaPackages; [
        dracula-theme
	hydra
	multiple-cursors
	which-key
      ]))
    ];
    #xsession = {
    #  enable = true;
    #};
    systemd.user.startServices = true;
    services = {
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
      };
    };
    programs = {
      #mtr.enable = true; ## Probably also a service
      git = {
        enable = true;
        userName = "Victor Albertsson";
        userEmail = "victor.albertsson@protonmail.com";
      };
    };
  };
}
