# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).  
{ config, pkgs, ... }:
{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./zram-swap.nix
      ./develop.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    useDHCP = false;
    interfaces.enp5s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    networkmanager.enable = true;
    # Open ports for KDE Connect
    firewall.allowedTCPPorts = [
                            1714 1715 1716 1717 1718 1719
        1720 1721 1722 1723 1724 1725 1726 1727 1728 1729
        1730 1731 1732 1733 1734 1735 1736 1737 1738 1739
        1740 1741 1742 1743 1744 1745 1746 1747 1748 1749
        1750 1751 1752 1753 1754 1755 1756 1757 1758 1759
        1760 1761 1762 1763 1764
    ];
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Kiev";
  location.provider = "geoclue2";

  services = {
    emacs = {
      enable = true;
      defaultEditor = true;
    };

    xserver.enable = true;

    clight = {
      enable = true;
      settings = { no_gamma = true; };
    };

    thermald.enable = true;
    acpid.enable = true;
    tlp.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    earlyoom.enable = true;
  };
  
  programs = {
    zsh.enable = false;        # nixos config slow
    gnome-disks.enable = true;
    udevil.enable = true;
  }; 

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
    libinput.enable = true;
    layout = "us, ru, ua";
    xkbOptions = "grp:win_space_toggle, caps:ctrl_modifier";
    xautolock = {
      enable = true;
      time = 15;
      notifier = '' ${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds" '';
      locker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
      extraOptions = [ "-lockaftersleep" ];
    };

    windowManager.xmonad = {
      enable = true;
      extraPackages = haskellPackages: [                      
        haskellPackages.xmonad-contrib_0_16                               
        haskellPackages.xmonad-extras                                
        haskellPackages.xmonad                                       
        haskellPackages.xmobar
      ];
    };
    windowManager.default = "xmonad";

    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager.lightdm = {
      enable = true;
      greeters.mini = {
        enable = true;
        user = "leniviy";
        extraConfig = ''
             [greeter]
             show-password-label = false
             [greeter-theme]
             font = Iosevka
             window-color = "#080800"
        '';
      };
    };
    displayManager.sessionCommands = ''xsetroot -cursor_name left_ptr
                                       nitrogen --restore
                                       compton -b
                                       clight &
                                       '';
  };

  users = {
    users.leniviy = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "adbusers" ]; 
    };
    defaultUserShell = pkgs.zsh;
  };

  fonts = {
    fonts = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        corefonts
        fira-code
        iosevka
        tewi-font
        siji
    ];

    fontconfig = {
      subpixel.rgba = "rgb";
      antialias = true; 
      hinting.enable = true;
      hinting.autohint = false;
      includeUserConf = false;
      defaultFonts = {
        monospace = [ "Iosevka" ];
        sansSerif = [ "Iosevka" ];
        serif = [ "Iosevka" ];
      };
    };  
  };

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      url = "https://github.com/nix-community/NUR/archive/3a6a6f4da737da41e27922ce2cfacf68a109ebce.tar.gz";
      sha256 = "04387gzgl8y555b3lkz9aiw9xsldfg4zmzp930m62qw8zbrvrshd";
  }) {
      inherit pkgs;
    };
  };

  environment.systemPackages = with pkgs; [
    binutils gnumake openssl pkgconfig
    wget curl sudo git dbus
    xclip xorg.xkill compton               # Xorg
    qutebrowser                            # Browser
  ];
   
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system = {
    stateVersion = "19.09";
    autoUpgrade.enable = true;
  };
}

