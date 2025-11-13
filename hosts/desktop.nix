# /etc/nixos/hosts/desktop.nix

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration-desktop.nix
    ../modules/system.nix
    ../modules/hardware.nix
    ../modules/network.nix # <-- Hostname needs to be reflected here
    ../modules/packages-plasma.nix
    ../modules/desktop-common.nix
    ../modules/gaming.nix
    ../modules/plasma.nix
  ];

  networking.hostName = "desktop"; # <-- Reflect changes in network.nix

  # Hyprland / Wayland
  programs.hyprland.enable = true;
  environment.variables.WLR_RENDERER = "vulkan"; # AMD Hardware Acceleration

  # Define user 'j'
  users.users.j = {
    isNormalUser = true;
    description = "j";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "gamemode" ];
  };

  system.stateVersion = "25.05";
}
