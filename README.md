# Code snippets
```bash
nix-shell -p nixFlakes
```
```bash
nix build '.#nixosConfigurations.nixos-desktop.config.system.build.toplevel' \
    --experimental-features "nix-command flakes"
```
```bash
./result/bin/switch-to-configuration switch
```
```bash
nix build github:VictorAlbertsson/nixos-config/master#nixos-desktop \
    --experimental-features "nix-command flakes"
```
```bash
nixos-install --root /mnt --system ./result
```
