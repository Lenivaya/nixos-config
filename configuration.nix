{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./modules

       <home-manager/nixos>
  ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  networking = {
    # useDHCP = false;
    # useNetworkd = true;
    # interfaces.enp5s0.useDHCP = true;
    # interfaces.wlp3s0.useDHCP = true;
    networkmanager.enable = true;
    # Open ports for KDE Connect
    firewall.allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
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
      shell = pkgs.zsh;
    };
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf ];
  programs.dconf.enable = true;

  services = {
    emacs = {
      enable = true;
      defaultEditor = true;
    };

    clight.enable = true;
    xserver.enable = true;
    xbanish.enable = true;

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
    zsh = {
      enable = true;
      # Slow
      enableCompletion = false;
      enableGlobalCompInit = false;
      promptInit = "";
      setOptions = [];
    };
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
        enable = true;
	haskellPackages = pkgs.unstable.haskellPackages;
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
    };
	
    displayManager.lightdm = {
      enable = true;
      greeters.gtk.theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome3.gnome_themes_standard;
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

