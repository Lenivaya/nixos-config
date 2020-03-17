{ pkgs, ... }:

{
  home-manager.users.leniviy = { pkgs, ... }:
    with import <nixpkgs> { };
    let unstable = import <unstable> { };
    in {

      xdg.enable = true;

      gtk.enable = true;
      gtk = {
        iconTheme = {
          package = pkgs.paper-icon-theme;
          name = "Paper";
        };
        theme = {
          package = pkgs.gnome3.gnome_themes_standard;
          name = "Adwaita-dark";
        };
        gtk3.extraConfig = {
          gtk-decoration-layout = "appmenu:none";
          gtk-cursor-theme-name = "Adwaita";
          gtk-cursor-theme-size = 0;
        };
      };

      qt.enable = true;
      qt.platformTheme = "gnome";

      services = {
        kdeconnect.enable = true;

        sxhkd = {
          enable = true;
          keybindings = {
            "super + Escape" = "pkill -USR1 -x sxhkd";
            "super + KP_Left" = "st -e ranger";
            "super + shift + KP_Left" = "st -e nnn";
            "super + KP_Home" = "st -e tmux";
          };
        };

        compton = {
          enable = true;
          package = unstable.picom;
          activeOpacity = "1.0";
          inactiveOpacity = "0.8";
          opacityRule = [
            "100:name *= 'i3lock'"
            "95:class_g *?= 'tabbed'"
            "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
            "96:_NET_WM_STATE@:32a *= '_NET_WM_STATE_STICKY'"
          ];
          backend = "glx";
          blurExclude = [ "window_type = 'dock'" "window_type = 'desktop'" ];
          fade = true;
          fadeDelta = 5;
          fadeSteps = [ "0.03" "0.03" ];
          shadow = true;
          shadowOffsets = [ 1 1 ];
          shadowOpacity = "0.3";
          vSync = "opengl-swc";
        };

        gpg-agent = {
          enable = true;
          defaultCacheTtl = 1800;
          enableSshSupport = true;
        };
      };

      programs = {
        broot.enable = true;
        bat.enable = true;
        fzf.enable = true;
        #password-store = {
        #  enable = true;
        #  settings = {
        #    PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
        #    PASSWORD_STORE_CLIP_TIME = "60";
        #  };
        #};

        rofi = {
          enable = true;
          lines = 10;
          scrollbar = true;
          cycle = true;
          theme = "gruvbox-dark-hard";
          extraConfig = ''
            rofi.modi: drun
          '';
        };

        git = {
          userName = "Lenivaya";
          userEmail = "xocada@gmail.com";
        };

        gpg.enable = true;

        home-manager = {
          enable = true;
          path = "...";
        };
      };
    };
}
