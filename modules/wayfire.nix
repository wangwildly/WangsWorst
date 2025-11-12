# Wayfire Desktop Environment
# Wayland Compositor, Tiling Window Manager, Works with SDDM

{ config, pkgs, ... }:

{
  # Enables Wayfire Compositor
  programs.wayfire.enable = true;

  # Adds Wayfire to the SDDM session list
  services.displayManager.sessionPackages = [ pkgs.wayfire ];

  # Adds core 'wf-shell' plugin for the panel/background
  #    and 'wcm' aka Wayfire Config Manager GUI
  environment.systemPackages = [
    pkgs.wf-shell
    pkgs.wcm
  ];
}