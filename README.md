~ nix-shell -p nixFlakes ~
~ [sudo] nix build '.#nixosConfigurations.nixos-desktop.config.system.build.toplevel' --experimental-features "nix-command flakes" ~
~ [sudo] ./result/bin/switch-to-configuration switch ~
~ [sudo] nix build github:VictorAlbertsson/nixos-config/master#nixos-desktop --experimental-features "nix-command flakes" ~
~ [sudo] nixos-install --root /mnt --system ./result ~