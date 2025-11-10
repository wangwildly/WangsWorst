{ config, pkgs, ... }:
{
  # Gnome Install Pre 25.11 - As of 25.11 it will no longer live in Xserver module
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = true;

  # As of 25.11
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;


}
