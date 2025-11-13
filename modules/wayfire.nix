{ config, pkgs, ... }:
{
  # Enables Wayfire & add it to the login screen
  programs.wayfire.enable = true;
  services.displayManager.sessionPackages = [ pkgs.wayfire ];


}