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
    # pkgs.hyprpaper  # Wallpaper
    pkgs.hyprlock # The lock screen
    pkgs.wlogout  # A graphical logout menu
    pkgs.mako          # Notification daemon
    pkgs.grim          # Screenshot tool
    pkgs.slurp         # Screen region selector
    pkgs.pamixer       # Volume control
    pkgs.wl-clipboard # Clipboard tool for wayland

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

  # === DESKTOP SERVICES ===
  services.mako = {
    enable = true;
    # You can customize it here later
    # For example:
    # backgroundColor = "#2E3440";
    # borderColor = "#88C0D0";
    # borderRadius = 5;
  };
  
  # === Hypridle Power Management ===
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock"; # Command to run for locking
      };

      listener = [
        # Lock screen after 300s (5 mins) of inactivity
        { timeout = 300; on-timeout = "hyprlock"; }

        # Turn off monitors after 600s (10 mins)
        { timeout = 600; on-timeout = "hyprctl dispatch dpms off"; on-resume = "hyprctl dispatch dpms on"; }
      ];
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

  xdg.configFile."wallpapers" = {
    source = ./dotfiles/wallpapers;
    recursive = true;
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
        "$mainMod, Left, movefocus, l"
        "$mainMod, Right, movefocus, r"
        "$mainMod, Up, movefocus, u"
        "$mainMod, Down, movefocus, d"
        
        "$mainMod SHIFT, Left, movewindow, l"
        "$mainMod SHIFT, Right, movewindow, r"
        "$mainMod SHIFT, Up, movewindow, u"
        "$mainMod SHIFT, Down, movewindow, d"

        # --- Workspace Controls (Numpad by Key Code) ---
        # This bypasses NumLock issues
        "$mainMod, code:87, workspace, 1"  # Numpad 1
        "$mainMod, code:88, workspace, 2"  # Numpad 2
        "$mainMod, code:89, workspace, 3"  # Numpad 3
        "$mainMod, code:83, workspace, 4"  # Numpad 4
        "$mainMod, code:84, workspace, 5"  # Numpad 5
        "$mainMod, code:85, workspace, 6"  # Numpad 6
        "$mainMod, code:79, workspace, 7"  # Numpad 7
        "$mainMod, code:80, workspace, 8"  # Numpad 8
        "$mainMod, code:81, workspace, 9"  # Numpad 9
        "$mainMod, code:90, workspace, 10" # Numpad 0

        # --- Move Window to Workspace (Numpad by Key Code) ---
        "$mainMod SHIFT, code:87, movetoworkspace, 1"
        "$mainMod SHIFT, code:88, movetoworkspace, 2"
        "$mainMod SHIFT, code:89, movetoworkspace, 3"
        "$mainMod SHIFT, code:83, movetoworkspace, 4"
        "$mainMod SHIFT, code:84, movetoworkspace, 5"
        "$mainMod SHIFT, code:85, movetoworkspace, 6"
        "$mainMod SHIFT, code:79, movetoworkspace, 7"
        "$mainMod SHIFT, code:80, movetoworkspace, 8"
        "$mainMod SHIFT, code:81, movetoworkspace, 9"
        "$mainMod SHIFT, code:90, movetoworkspace, 10"

        # --- Screenshots (grim + slurp) ---
        # Full screen
        ", Print, exec, grim - | wl-copy" 
        # Select region
        "$mainMod, Print, exec, grim -g \"$(slurp)\" - | wl-copy" 

        # --- Volume Keys (pamixer) ---
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
      

      ];
      
      # Wallpaper manager
      programs.wpaperd = {
          enable = true;
          settings = {
            default = {
            # This is the magic:
            # '%c' is a special variable for ~/.config
            # So this points to the wallpaper folder we just linked!
            path = "%c/wallpapers/";
        
            # How often to cycle. "30m" = 30 minutes
            duration = "30m"; 
        
            # Apply to your monitors
            outputs = [ "DP-2" "DP-3" ];
          };
        };
      };

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