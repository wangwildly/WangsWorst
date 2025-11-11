# /etc/nixos/hosts/laptop.nix

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration-laptop.nix
    ../modules/system.nix
    ../modules/hardware.nix
    ../modules/network.nix # <-- networking.hostName needs to be reflected here
    ../modules/packages.nix
    ../modules/desktop-common.nix
    ../modules/plasma.nix
  ];

  networking.hostName = "laptop"; # <-- This needs to be reflected in network.nix

  # Define user 'ju'
  users.users.ju = {
    isNormalUser = true;
    description = "ju";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  system.stateVersion = "25.05";
}
