{ pkgs, ... }:

{
  home-manager.users.leniviy.home.packages = with pkgs; [
    # some rust apps
    ripgrep               # fast grepper
    fd                    # rust alternative to find
    exa                   # ls alternative
    tokei                 # code statistic

    tmux
    maim scrot                          # Screenshots
    dunst                               # notification daemon
    notify-osd
    neofetch                            # fetch
    htop
    usbutils unzip zip unrar
    ncdu                      # Disk space usage anlyzer
    android-file-transfer
    openvpn protonvpn-cli     # vpn
    sxiv
    zathura pandoc
    nitrogen
    ps_mem
    pulsemixer
    pass
    lm_sensors
    vscode
    discord
    spotify

    # Emacs as email client
    mu
    isync

    # Appearance
    qt5ct lxappearance
    plasma5.breeze-qt5
    materia-theme
    pywal wpgtk

    killall
    stow
  ]
  ++
  (with pkgs.unstable; [
    vim neovim
    alacritty
    starship
    nnn
    ranger
    xmobar
    jgmenu
    tdesktop
    betterlockscreen
    qutebrowser
    pfetch
  ])
  ++
  (with pkgs.gnome3; [
    adwaita-icon-theme
    nautilus file-roller gnome-autoar
    eog
  ])
  ++
  (with pkgs.pantheon; [
    elementary-camera
    elementary-calendar
    elementary-calculator
  ]);
}
