# /etc/nixos/modules/packages.nix
{ config, pkgs, ... }:

{
  # === SYSTEM PACKAGES ===
  environment.systemPackages = [
    # System tools
    pkgs.htop
    pkgs.fastfetch
    pkgs.alacritty

    # Development
    pkgs.vscode
    pkgs.git

    # Gaming
    pkgs.mangohud
    pkgs.goverlay
    pkgs.heroic

    # Desktop apps
    pkgs.discord
    pkgs.kdePackages.partitionmanager
    pkgs.kdePackages.kate
    pkgs.google-chrome

    # Kvantum Theme Manager
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.qt6Packages.qtstyleplugin-kvantum
    pkgs.kvantum

    # Popular theme collections
    pkgs.kvantum-themes
    pkgs.materia-kde-theme

    # System utilities
    pkgs.usbutils
    pkgs.pciutils
  ];

  # === NIXPKGS CONFIG ===
  nixpkgs.config.allowUnfree = true;
}