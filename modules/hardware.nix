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
  services.udev = {
    packages = [ pkgs.game-devices-udev-rules ];

    # Rules to give 'wheel' group access to Keychron devices
    extraRules = ''
      # === Keychron K4 HE ===
      # VID=3434, PID=0e40
      SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0e40", GROUP="wheel"
     SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0e40", GROUP="wheel"

      # === Keychron M3 mini 8K ===
      # VID=3434, PID=d051
      SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d051", GROUP="wheel"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d051", GROUP="wheel"
    '';
  };
}

