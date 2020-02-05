{ config, ... }:

{
  boot = {
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.efiSupport = true;
      grub.device = "nodev";
      grub.efiInstallAsRemovable = true; # NVRAM is unreliable
    };
  };
}
