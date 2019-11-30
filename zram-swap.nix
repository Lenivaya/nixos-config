{ config, pkgs, ... }:
{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 40;
    numDevices = 1;
    priority = 10;
  };
}
