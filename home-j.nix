# Desktop Home-Manager
# Immense commentary for education

{ config, pkgs, ... }:

{
  # This should match the stateVersion in your configuration.nix
  home.stateVersion = "25.05";

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

    # Hyperland-Specific
    pkgs.hyperpaper # Wallpaper manager
    pkgs.hypridle # Idle daemon
    pkgs.hyprlock # Lock screen
    pkgs.pyprland # Advanced features
    pkgs.waybar # Status bar
    pkgs.rofi-wayland # App launcher
    pkgs.kitty # Terminal
    pkgs.neofetch # System info / Porn for Linux gooners
    pkgs.lazygit # Terminal UI for GIT commands
    pkgs.lazydocker # Terminal UI for Docker
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

  # Hyprland config is built on fish
  programs.fish.enable = true;

  # Dotfiles (Declaratively Linked)
  xdg.configFile."hypr" = {
    source = ../dotfiles/hypr;
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = ../dotfiles/waybar;
    recursive = true;
  };

  xdg.configFile."rofi" = {
    source = ../dotfiles/rofi;
    recursive = true;
  };

  xdg.configFile."fish" = {
    source = ../dotfiles/fish;
    recursive = true;
  };

  xdg.configFile."kitty" = {
    source = ../dotfiles/kitty;
    recursive = true;
  };

  xdg.configFile."neofetch" = {
    source = ../dotfiles/neofetch;
    recursive = true;
  };

  # Hyprland Home-Manager
  wayland.windowManager.hyprland = {
    enable = true;
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