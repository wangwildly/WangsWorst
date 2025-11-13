# /etc/nixos/hosts/laptop.nix

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration-laptop.nix
    ../modules/system.nix
    ../modules/network.nix # <-- networking.hostName needs to be reflected here
    ../modules/packages-plasma.nix
    ../modules/desktop-common.nix
    ../modules/laptop-peripherals.nix
    ../optional/nvidia.nix
    ../modules/wayfire.nix
    ../modules/plasma.nix
  ];

  networking.hostName = "laptop"; # <-- This needs to be reflected in network.nix

  # === 3. CONFIGURE NVIDIA PRIME OFFLOAD ===
  hardware.nvidia.prime = {
    offload.enable = true;
    # === USE YOUR BUS IDS FROM 'lspci' HERE ===
    intelBusId = "PCI:00:02.0";    # (Example: 00:02.0)
    nvidiaBusId = "PCI:01:00.0";   # (Example: 01:00.0)
  };

  # === 4. LAPTOP-SPECIFIC SETTINGS ===
  services.logind.lidSwitchExternalPower = "ignore";
  services.hardware.bolt.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.unfreePackages.brscan5 ];
  hardware.scanbd.enable = true;

  # Define user 'ju'
  users.users.ju = {
    isNormalUser = true;
    description = "ju";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "scanner" ];
  };

  system.stateVersion = "25.05";
}
