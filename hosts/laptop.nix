# /etc/nixos/hosts/laptop.nix
{ config, pkgs, ... }:
{
  imports = [
    # Machine-specific hardware
    ./hardware-configuration-laptop.nix

    # Shared modules
    ../modules/system.nix
    ../modules/hardware.nix
    ../modules/network.nix
    ../modules/packages.nix
    ../modules/users.nix
    ../modules/desktop-common.nix

    # Laptop-specific modules
    ../modules/gnome.nix
  ];

  # Set laptop hostname
  networking.hostName = "laptop";
}
