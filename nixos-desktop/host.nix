{ system, config, pkgs, modulesPath, inputs, ... }:
let
  nixos-unstable = import inputs.unstable {
    config = config.nixpkgs.config;
    localSystem = system;
  };
in {

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = nixos-unstable.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.loader.systemd-boot.enable = true;
  fileSystems."/boot".device = "/dev/disk/by-label/boot";
  fileSystems."/".device = "/dev/disk/by-label/nixos";
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  time.timeZone = "Europe/Stockholm";
  sound.enable = true;

  hardware = {
    #bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    steam-hardware.enable = true;
  };

  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
    interfaces.enp4s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
  };

  services = {
    printing.enable = true;
    sshd.enable = true;
    #blueman.enable = true;
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
    #xserver.displayManager.session = [
    #  { manage = "desktop"; name = "xsession"; start = "exec $HOME/.xsession"; }
    #];
    #xserver.displayManager.defaultSession = "xsession";
    #libinput.enable = true; ## For touch(pad) support
    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
    };
  };

  #nixpkgs.overlays = [ ];

  #environment.systemPackages = with pkgs; [ ];

  users.users.victor = {
    isNormalUser = true;
    extraGroups = [
      "users" 
      "wheel"
      "input"
      "audio"
      "networkmanager"
    ];
  };
}

