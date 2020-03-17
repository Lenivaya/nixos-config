{
  imports = [
    ./pkgs.nix
    ./hardware.nix
    ./zram-swap.nix
    ./docker.nix
    ./overrides.nix

    ./fonts
    ./boot
    ./home-manager
  ];
}
