
{
  description = "My NixOS configuration";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-21.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "stable";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs:
  let # TODO Make flakeSystem take a list of users
    flakeSystem = system: host: user: inputs.stable.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.unstable.nixosModules.notDetected # Replaces hardware-configuration.nix
        {
          nixpkgs.overlays = [
            inputs.nur.overlay
          ];
        }
        (./hosts + "/${host}.nix")
        (./users + "/${user}.nix")
      ];
      specialArgs = {
        inherit inputs;
        inherit system;
        inherit host;
        inherit user;
      };
    };
  in
  {
    # Alias(es) for easy builds
    nixos-desktop = inputs.self.nixosConfigurations.nixos-desktop.config.system.build.toplevel;
    # Actual system configuration
    nixosConfigurations = {
      nixos-desktop = flakeSystem "x86_64-linux" "nixos-desktop" "victor";
    };
  };
}
