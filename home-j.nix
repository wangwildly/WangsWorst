# Desktop Home-Manager
# Immense commentary for education

{ config, pkgs, ... }:

{
  # This should match the stateVersion in your configuration.nix
  home.stateVersion = "25.05";

# === CORE HOME-MANAGER SERVICES ===
  # This fixes configs not loading
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

    # === HYPRLAND DESKTOP ===
    pkgs.kitty      # terminal
    pkgs.wofi       # app launcher
    pkgs.waybar     # status bar
    pkgs.hyprpaper  # Wallpaper
    pkgs.hyprlock # The lock screen
    pkgs.wlogout  # A graphical logout menu

    # Development - Keeping these here and commented out for my education
    # These are currently handled in user-level programs & config, so it manages dotfiles.
    # pkgs.vscode
    # pkgs.git
    pkgs.neovim

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

  # === WINDOW MANAGER (HYPRLAND) ===
  wayland.windowManager.hyprland = {
    enable = true;
    
    # This is our config, from scratch.
    settings = {
      # === Core ===
      "$mainMod" = "SUPER"; # Your Super key
      "monitor" = ",preferred,auto,1"; # Auto-detect monitors
      
      # === Autostart ===
      "exec-once" = [
        "waybar"
        "hyprpaper"
      ];
      
      # === Keybinds ===
      "bind" = [
        # --- Apps ---
        "$mainMod, T, exec, kitty"
        "$mainMod, D, exec, wofi --show drun"
        "$mainMod, Q, killactive,"
        
        # --- Session Controls ---
        "$mainMod, L, exec, hyprlock"             # Lock screen
        "$mainMod, M, exec, wlogout"              # Logout menu
        
        # --- Window Movement ---
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # --- Workspace Controls ---
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # --- Move Window to Workspace ---
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      
      ];
      
      # Add more settings here as we go...
    };
  };
  
  # === THEMING ===
  # This sets Kvantum to handle QT Style instead of KDE
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };
  
  # This just lets home-manager manage itself
  programs.home-manager.enable = true;
}