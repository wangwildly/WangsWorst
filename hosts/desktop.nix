# /etc/nixos/hosts/desktop.nix
{ config, pkgs, ... }:
{
  imports = [
    # Machine-specific hardware
    ./hardware-configuration-desktop.nix

    # Shared modules
    ../modules/system.nix
    ../modules/hardware.nix
    ../modules/network.nix
    ../modules/packages.nix
    ../modules/users.nix
    ../modules/desktop-common.nix

    # Desktop-specific modules
    ../modules/gaming.nix
    ../modules/plasma.nix
  ];

  # Set desktop hostname (you'll need to update modules/network.nix)
  networking.hostName = "desktop";

  # Other machine-specific settings could go here
}
