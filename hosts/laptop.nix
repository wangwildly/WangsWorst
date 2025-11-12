# /etc/nixos/hosts/laptop.nix

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration-laptop.nix
    ../modules/system.nix
    ../modules/hardware.nix
    ../modules/network.nix # <-- networking.hostName needs to be reflected here
    ../modules/packages.nix
    ../modules/desktop-common.nix
    ../modules/plasma.nix
    ../modules/wayfire.nix
  ];

  networking.hostName = "laptop"; # <-- This needs to be reflected in network.nix

  # === DOCK-SPECIFIC ===
  # services.logind.lidSwitchExternalPower = "ignore"; # Clamshell mode
  services.hardware.bolt.enable = true; # Thunderbolt manager
  services.power-profiles-daemon.enable = true;

  # Making Wayland use Vulkan for HW accel
  environment.variables.WLR_RENDERER = "vulkan";

  # Add swayidle to handle events like closing the lid
    services.swayidle = {
    enable = true;
    # This tells swayidle to listen for the lid switch event
    # and run a command to turn OFF your laptop screen.
    events = [
      {
        event = "lid-switch";
        # IMPORTANT: Replace 'eDP-1' if your screen name was different!
        command = "${pkgs.sway}/bin/swaymsg 'output eDP-1 dpms off'";
      }
    ];
    # This part tells it to turn the screen back ON
    # when the lid is opened.
    timeouts = [
      {
        timeout = 1; # Does nothing, just a placeholder
        command = ""; # Does nothing
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output eDP-1 dpms on'";
      }
    ];
  };


  # Define user 'ju'
  users.users.ju = {
    isNormalUser = true;
    description = "ju";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  system.stateVersion = "25.05";
}
