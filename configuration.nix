{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # === BOOT & KERNEL ===
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3; # Faster boot menu
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # Enable some useful kernel modules
    kernelModules = [ "kvm-amd" ];
  };

# === HARDWARE ===
hardware = {
  cpu.amd.updateMicrocode = true;
  # Add bluetooth support
  bluetooth = {
    enable = true;
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true; # for better device support
      };
    };
  };
  
    # Modern OpenGL config (replaces hardware.opengl)
    graphics = {
      enable = true;
      enable32Bit = true; # For Steam/gaming
      extraPackages = with pkgs; [ 
        amdvlk # AMD Vulkan driver
        vaapiVdpau 
        libvdpau-va-gl 
      ];
    };
    steam-hardware.enable = true;
  };

  # === NETWORKING ===
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # Enable firewall by default (security)
    firewall.enable = true;
  };

  # === LOCALIZATION ===
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  # === DISPLAY & DESKTOP ===
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    
    # Add bluetooth service
    blueman.enable = true; # GUI bluetooth manager

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true; # Modern session manager
    };
    
    printing.enable = true;
    flatpak.enable = true;
    
    # Useful services
    fwupd.enable = true; # Firmware updates
    thermald.enable = true; # CPU thermal management
  };

  #Enable/Disable Kvantum Themes
  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };

  # === SECURITY ===
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # === USERS ===
  users.users.j = {
    isNormalUser = true;
    description = "j";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "gamemode" ];
    packages = with pkgs; [
      # User-specific packages (consider moving to home-manager later)
    ];
  };

  # === PROGRAMS ===
  programs = {
    firefox.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
    dconf.enable = true; # Needed for some apps
  };

  # === SYSTEM PACKAGES ===
  environment.systemPackages = with pkgs; [
    # System tools
    htop
    fastfetch
    alacritty
    
    # Development
    vscode
    git # Essential for development
    
    # Gaming
    mangohud
    goverlay
    heroic
    
    # Desktop apps
    discord
    kdePackages.partitionmanager
    kdePackages.kate
    google-chrome

    #Kvantum Theme Manager
    libsForQt5.qtstyleplugin-kvantum  # For Qt5 apps
    qt6Packages.qtstyleplugin-kvantum # For Qt6 apps (optional but recommended)
    kvantum                           # The theme manager GUI

    # Popular theme collections:
    kvantum-themes    # Collection of various themes
    materia-kde-theme # Includes Kvantum themes

    # System utilities
    usbutils
    pciutils
  ];

# === NIX SETTINGS ===
nix = {
  settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    # Parallel builds for faster compilation
    max-jobs = "auto";
    cores = 0; # Use all cores
  };
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
};

# === MISC ===
nixpkgs.config.allowUnfree = true;
services.udev.packages = [ pkgs.game-devices-udev-rules ];

# Don't forget this at the very end!
system.stateVersion = "25.05";

}  # This closes the entire configuration