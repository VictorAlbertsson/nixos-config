# NixOS flake

```bash
nix build github:VictorAlbertsson/nixos-config/master#nixos-desktop
```

# NixOS without flakes

```bash
nix-shell -p nixFlakes
```
```bash
nix build github:VictorAlbertsson/nixos-config/master#nixos-desktop \
    --experimental-features "nix-command flakes"
```
```bash
./result/bin/switch-to-configuration switch
```

# Bootstrap

- Partition drive(s)
- Mount partitions
- Then:

```bash
nix-shell -p nixFlakes
```
```bash
nix build github:VictorAlbertsson/nixos-config/master#nixos-desktop \
    --experimental-features "nix-command flakes"
```
```bash
nixos-install --root /mnt --system ./result
```
