# ** IMPORTANT **
# If copying my setup with NVIDIA GPU then do the following:
#
# sudo mv /etc/nixos/modules/hardware.nix /etc/nixos/optional/hardware.nix
# sudo mv /etc/nixos/optional/nvidia.nix /etc/nixos/modules/nvidia.nix
# 
# Doing this will ignore my AMD hardware and replace it with nvidia drivers
# ** IMPORTANT **

{ config, pkgs, ... }:
{
  imports = [ # <-- This section imports modules
  
    ./desktop-hardware.nix # <-- change this to your host file in /etc/nixos/hosts
    # Generate and name your host file by following directions below in a Terminal window
    # sudo nixos-generate-config
    # sudo mv /etc/nixos/hardware-configuration.nix /etc/nixos/hosts/desktop-hardware.nix

    # Here you can import modules from /etc/nixos/modules, examples:
    ../modules/system.nix
    ../modules/network.nix
    ../modules/desktop-common.nix
    ../modules/plasma.nix
    ../modules/packages.nix
    # ...etc...
    # ** DO NOT include ../modules/hardware.nix !! Read above if you haven't!**

    # 3. The NVIDIA module
    ../modules/nvidia.nix
  ];

  # ... Hostname, user, and stateVersion...
  networking.hostName = "your-host-name"; # <-- This should be your actual host name
  system.stateVersion = "25.05";
  users.users.your-username = { # <-- change this to your username
    isNormalUser = true; # <-- don't fuck with this
    extraGroups = [ "wheel" "networkmanager" ]; # <-- don't fuck with this
  };
} # <-- This is the end of the configuration