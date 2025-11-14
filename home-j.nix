# Desktop Home-Manager
# Immense commentary for education

{ config, pkgs, ... }:

{
  # This should match the stateVersion in your configuration.nix
  home.stateVersion = "25.05";


  # This kickstarts user services
  dconf.enable = true;
  systemd.user.startServices = true;
  
  # === USER-LEVEL PACKAGES ===
  # My apps
  home.packages = [
    # Media players:
    pkgs.vlc
    pkgs.spotify
    pkgs.haruna

    # Codecs (GStreamer plugins cover webm, mp4, etc.)
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.libde265 # For H.265 / HEVC

    # System tools
    pkgs.htop
    pkgs.fastfetch
    pkgs.libsecret

    # Development - Keeping these here and commented out for my education
    # These are currently handled in user-level programs & config, so it manages dotfiles.
    # pkgs.vscode
    # pkgs.git

    # Wayfire Desktop apps
    pkgs.kitty # Terminal
    pkgs.wofi # App launcher
    pkgs.waybar # Status bar
    pkgs.swaybg # For setting a wallpaper

    # Gaming
    pkgs.mangohud
    pkgs.goverlay
    pkgs.heroic
    pkgs.protonup-qt
    pkgs.lutris
    pkgs.protonplus
    pkgs.gamescope
    pkgs.corefonts

    # Desktop apps
    pkgs.discord
    pkgs.google-chrome
    pkgs.bottles
    pkgs.bolt-launcher
    pkgs.runelite

  ];

  # === USER-LEVEL PROGRAMS & CONFIG ===
  # Dotfiles and services are managed here
  
  # This installs git, and generates a ~/.gitconfig
  programs.git = {
    enable = true;
    userName = "wangwildly";
    userEmail = "wangwetly@pm.me";
    
    # Writes to .gitconfig file
    extraConfig = {
      credential.helper = "libsecret"; # Saves git config
    };
  };

  # Wayfire config
  xdg.configFile."wayfire.ini" = {
  source = ./dotfiles/wayfire.ini;
  };

  # Waybar config & style
  xdg.configFile."waybar" = {
    source = ./dotfiles/waybar;
    recursive = true; # Copies entire folder
  };


  # This installs VSCode and manages its extensions, can be done declaratively I guess
  programs.vscode = {
    enable = true;
  };

  # Enables Firefox, and manages its dotfiles
  programs.firefox.enable = true;

  # Librewolf 
  programs.librewolf = {
    enable = true;
    # This is to manage its settings
    settings = {
      "webgl.disabled" = true;
    };
  };

  # Brave Browser
  programs.brave = {
    enable = true;
    # You can add extensions declaratively if you want, might look into this.
    # Example below provided by unhinged /b/ user
    # extensions = [
    #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    #   { id = "nngceckbapebfimnlniiabkandclnoej"; } # Bitwarden
    # ];
  };

  # === THEMING ===
  # This sets Kvantum to handle QT Style instead of KDE
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };
  
  # This just lets home-manager manage itself
  programs.home-manager.enable = true;
}