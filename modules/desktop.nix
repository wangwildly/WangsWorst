# /etc/nixos/modules/desktop.nix
{ config, pkgs, ... }:

{
  services = {
    # === DISPLAY & DESKTOP ===
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    
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

  # === THEMING ===
  # Kvantum environment variable
  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };
}