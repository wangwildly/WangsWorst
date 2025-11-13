# /etc/nixos/hosts/laptop.nix

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration-laptop.nix
    ../modules/system.nix
    ../modules/hardware.nix
    ../modules/network.nix # <-- networking.hostName needs to be reflected here
    ../modules/packages-plasma.nix
    ../modules/desktop-common.nix
    ../modules/plasma.nix
    ../modules/laptop-peripherals.nix
    ../modules/wayfire.nix
  ];

  networking.hostName = "laptop"; # <-- This needs to be reflected in network.nix

  xdg.portal = {
    enable = true;
    # Tell it to use the 'wlr' backend for Wayfire/Sway
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    # Explicitly set the default to 'wlr'
    config.common.default = "*";
  };


  # Thunderbolt and power profile for Dock
  services.hardware.bolt.enable = true; # Thunderbolt manager
  services.power-profiles-daemon.enable = true;

  # System-Wide scanning ability (add "scanner" to extraGroups to use this)
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.brscan5 ];

  # Define user 'ju'
  users.users.ju = {
    isNormalUser = true;
    description = "ju";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "scanner" ];
  };

  system.stateVersion = "25.05";
}
