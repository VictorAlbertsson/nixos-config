
{
  description = "My NixOS configuration";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-21.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = inputs:
    let
      # NOTE Using the master branch here to access hardware.zsa
      # attribute, which is not yet available on stable/unstable
      # TODO Make `flakeSystem' take a list of users
      flakeSystem = system: host: user: inputs.master.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.unstable.nixosModules.notDetected
          (./hosts + "/${host}.nix")
          (./users + "/${user}.nix")
        ];
        specialArgs = {
          inherit inputs;
          inherit system;
          #inherit host;
          #inherit user;
        };
      };
    in {
      # Alias(es) for easy builds
      nixos-desktop = inputs.self.nixosConfigurations.nixos-desktop.config.system.build.toplevel;
      # Actual system configuration(s)
      nixosConfigurations = {
        nixos-desktop = flakeSystem "x86_64-linux" "nixos-desktop" "victor";
      };
    };
}
