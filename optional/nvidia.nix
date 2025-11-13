# /etc/nixos/modules/nvidia.nix
# For friends/family who don't yet understand the magic of NixOS (or AMD hardware)
{ config, pkgs, ... }:

{
  # This allows proprietary NVIDIA drivers
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptEula = true;
  };

  # This is for OpenGL and 32-bit support for Steam/Whatever
  hardware.opengl = {
    enable = true;
    enable32Bit = true;
  };

  # This tells Xorg/XWayland to use the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Main NVIDIA driver settings
  hardware.nvidia = {

    # Enables Wayland/modern display support
    # This is crucial for Gnome/Plasma on Wayland
    modesetting.enable = true;

    # Enables power management (suspend/resume)
    powerManagement.enable = true;

    # This is the (worse) open source driver, I recommend never enabling it
    # I'm only including it in case of some kind of crazy edge-case that requires it
    open = false; 
  };
}