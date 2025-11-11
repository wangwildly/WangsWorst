# /etc/nixos/modules/desktop-common.nix
{ config, pkgs, ... }:
{
  services = {
    # === DISPLAY & DESKTOP ===
    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    # GUI bluetooth manager
    blueman.enable = true; 

    # === AUDIO ===
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # === OTHER DESKTOP SERVICES ===
    printing.enable = true;
    flatpak.enable = true;
  };
}
