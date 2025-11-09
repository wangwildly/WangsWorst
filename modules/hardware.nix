# /etc/nixos/modules/hardware.nix
{ config, pkgs, ...}:

{
  # === HARDWARE ===
  hardware = {
    cpu.amd.updateMicrocode = true;
    # Add bluetooth support
    bluetooth = {
      enable = true;
      powerOnBoot = true; # Powers up the default Bluetooth controller on boot
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true; # For better device support
        };
      };
    };

    # Modern OpenGL config (replaces hardware.opengl)
    graphics = {
      enable = true;
      enable32Bit = true; # For Old Steam/Other games
      extraPackages = [ 
        pkgs.amdvlk # AMD Vulkan driver
        pkgs.vaapiVdpau 
        pkgs.libvdpau-va-gl 
      ];
    };
  };

  # === HARDWARE-RELATED SERVICES ===
  services = {
    fwupd.enable = true; # Firmware updates
    thermald.enable = true; # CPU thermal management
  };

  # Adds udev rule for game devices
  services.udev.packages = [ pkgs.game-devices-udev-rules ];
}

