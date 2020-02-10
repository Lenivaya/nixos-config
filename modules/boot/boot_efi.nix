{ config, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    grub.enable = false;
    efi.canTouchEfiVariables = true;
  };
}
