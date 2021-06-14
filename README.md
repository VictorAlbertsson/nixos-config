# Code snippets
```bash
nix-shell -p nixFlakes
nix build '.#nixosConfigurations.nixos-desktop.config.system.build.toplevel' \
    --experimental-features "nix-command flakes"
./result/bin/switch-to-configuration switch
nix build github:VictorAlbertsson/nixos-config/master#nixos-desktop \
    --experimental-features "nix-command flakes"
nixos-install --root /mnt --system ./result
```
