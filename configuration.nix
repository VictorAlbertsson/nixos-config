# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath, inputs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  time.timeZone = "Europe/Stockholm";
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
    interfaces.enp4s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
  };

  services = {
    printing.enable = true;
    sshd.enable = true;
    xserver.enable = true;
    xserver.layout = "us";
    xserver.displayManager.sddm.enable = true;
    xserver.desktopManager.plasma5.enable = true;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  nixpkgs.overlays = [ ];

  environment.systemPackages = with pkgs; [
    git
    vim
    tree
    firefox
  ];

  users.users.victor = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "networkmanager"
    ];
  };
}

