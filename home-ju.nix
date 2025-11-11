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

    # Codecs (GStreamer plugins cover webm, mp4, etc.)
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.libde265 # For H.265 / HEVC

    # --- Packages moved from packages.nix ---
    # System tools
    pkgs.htop
    pkgs.fastfetch

    # Development
    # These are currently handled in user-level programs & config, so it manages dotfiles.
    # pkgs.vscode
    # pkgs.git

    # Gaming
    # pkgs.mangohud
    # pkgs.goverlay
    # pkgs.heroic
    # pkgs.protonup-qt

    # Desktop apps
    pkgs.discord
    # pkgs.kdePackages.partitionmanager
    # pkgs.kdePackages.kate
    # pkgs.google-chrome
  ];

  # === USER-LEVEL PROGRAMS & CONFIG ===
  # This is where dotfiles and services are managed.
  
  # This installs git, and generates a ~/.gitconfig
  programs.git = {
    enable = true;
    userName = "wangwildly-ju";
    userEmail = "wangwetly@pm.me";
  };
  
  # This installs VSCode and manages its extensions declaratively
  programs.vscode = {
    enable = true;
  };

  # Enables Firefox, and manages its dotfiles
  programs.firefox.enable = true;

  # Librewolf 
  programs.librewolf = {
    enable = true;
    # This is to manage settings
    settings = {
      "webgl.disabled" = true;
    };
  };

  # Brave Browser
  programs.brave = {
    enable = true;
    # You can add extensions declaratively if you want, might look into this.
    # For example:
    # extensions = [
    #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    #   { id = "nngceckbapebfimnlniiabkandclnoej"; } # Bitwarden
    # ];
  };

  # === THEMING ===
  # This sets Kvantum to handle QT Style instead of KDE
  # home.sessionVariables = {
   # QT_STYLE_OVERRIDE = "kvantum";
  
  
  # This just lets home-manager manage itself
  programs.home-manager.enable = true;
}
