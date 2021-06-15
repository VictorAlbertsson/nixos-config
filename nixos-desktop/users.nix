{ config, lib, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.victor = {
    home.homeDirectory = "/home/victor";
    xdg.userDirs.enable = true;
    home.keyboard.layout = "us";
    home.packages = with pkgs; [ vim tree firefox ];
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
