# /etc/nixos/modules/packages.nix
{ config, pkgs, ... }:

{
  # === SYSTEM PACKAGES ===
  # Only packages that the *system* needs
  environment.systemPackages = [
    # Kvantum Theme Manager
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.qt6Packages.qtstyleplugin-kvantum

    #KDE System Packages
    pkgs.kdePackages.kdeconnect-kde
    pkgs.kdePackages.partitionmanager

    #Deskflow
    pkgs.deskflow

    #Installs git
    pkgs.git

    # Popular theme collections
    pkgs.materia-kde-theme

    # System utilities
    pkgs.usbutils
    pkgs.pciutils
  ];

  # === NIXPKGS CONFIG ===
  nixpkgs.config.allowUnfree = true;
}
