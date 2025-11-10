# /etc/nixos/modules/desktop-common.nix
{ config, pkgs, ... }:

{
  services = {
    # === DISPLAY & DESKTOP ===
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Desktop Environment(s)
    # desktopManager.plasma6.enable = true; # <-- KDE Plasma 6 Desktop Environment
	#This is now handled by plasma.nix

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
