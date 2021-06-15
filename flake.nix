
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
    emacs.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs:
  let
    system = "x86_64-linux";
  in
  {
    # Alias(es) for easy builds
    nixos-desktop = inputs.self.nixosConfigurations.nixos-desktop.config.system.build.toplevel;
    # Actual system configuration
    nixosConfigurations = {
      nixos-desktop = inputs.stable.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.unstable.nixosModules.notDetected ## Replaces hardware-configuration.nix
          {
            nixpkgs.overlays = [
              inputs.nur.overlay
              inputs.emacs.overlay
              (next: prev: {
                unstable = (import inputs.unstable { inherit system; });
              })
            ];
          }
          ./nixos-desktop/host.nix
          ./nixos-desktop/users.nix
        ];
        specialArgs = { inherit inputs; inherit system; };
      };
    };
  };
}

