{ config, pkgs, ... }:

{
  # 1. Enable Wayfire & add it to the login screen
  programs.wayfire.enable = true;
  services.displayManager.sessionPackages = [ pkgs.wayfire ];

  # 2. Enable Hardware Acceleration
  environment.variables.WLR_RENDERER = "vulkan";
}