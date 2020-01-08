{ config, pkgs, ... }:
{
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 40;
    numDevices = 1;
    priority = 10;
  };
}
