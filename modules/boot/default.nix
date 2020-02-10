{ config, pkgs, ... }:

{
  imports = [
#    ./boot_grub.nix
    ./boot_efi.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.cleanTmpDir = true;
}
