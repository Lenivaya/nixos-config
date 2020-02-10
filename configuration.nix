{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix

      ./modules
  ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Kiev";
  location.provider = "geoclue2";

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "23:00";
      options = "--delete-older-than 30d";
    };
  };

  users = {
    extraUsers.leniviy = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "adbusers"
                      "docker" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  services.dbus.packages = with pkgs; [ gnome3.dconf ];
  programs.dconf.enable = true;

  services = {
    emacs = {
      enable = true;
      defaultEditor = true;
    };

    xserver.enable = true;
    xbanish.enable = true;

    clight = {
      enable = false;
      settings = { no_gamma = true; };
    };

    thermald.enable = true;
    acpid.enable = true;
    tlp.enable = true;
    upower.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    earlyoom.enable = true;
  };
  
  programs = {
    zsh.enable = false;        # slow
    gnome-disks.enable = true;
    udevil.enable = true;
  }; 

  services.xserver = {
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
    libinput.enable = true;
    layout = "us, ru, ua";
    xkbOptions = "grp:win_space_toggle, caps:ctrl_modifier";
    xautolock = {
      enable = true;
      time = 5;
      locker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
      extraOptions = [ "-lockaftersleep" ];
    };

    windowManager = {
      xmonad = {
        enable = false;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib_0_16
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
          haskellPackages.xmobar
        ];
     };
    };

    desktopManager = {
      xterm.enable = false;
      gnome3.enable = true;
    };
	
    displayManager.gdm.enable = true;

    displayManager.lightdm = {
      enable = false;
      greeters.gtk.theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome3.gnome_themes_standard;
      };
    };

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
        symbola
    ];

    fontconfig = {
      subpixel.rgba = "rgb";
      antialias = true; 
      hinting.enable = true;
      hinting.autohint = false;
      includeUserConf = true;
      defaultFonts = {
        monospace = [ "Iosevka" ];
        sansSerif = [ "Iosevka" ];
        serif = [ "Iosevka" ];
      };
    };  
  };

  environment.systemPackages = with pkgs; [
    wget curl git
    xclip xorg.xkill               # Xorg
  ];
   
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system = {
    stateVersion = "19.09";
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };
}

