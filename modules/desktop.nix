# /etc/nixos/modules/desktop.nix
{ config, pkgs, ... }:

{
  services = {
    # === DISPLAY & DESKTOP ===
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    
    # Desktop Environment(s)
    desktopManager.plasma6.enable = true; # <-- KDE Plasma 6 Desktop Environment
    desktopManager.gnome.enable = true; # <-- Gnome Desktop Environment

    # Add bluetooth service
    blueman.enable = true; # GUI bluetooth manager

    # === AUDIO ===
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true; # Modern session manager
    };
    
    # === OTHER DESKTOP SERVICES ===
    printing.enable = true;
    flatpak.enable = true;
  };
}