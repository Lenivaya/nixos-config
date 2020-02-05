{
  imports = [
    ./pkgs.nix
    ./hardware.nix
    ./zram-swap.nix
    ./docker.nix
    ./overrides.nix

    ./boot
  ];
}
