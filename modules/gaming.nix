# /etc/nixos/modules/gaming.nix
{ config, pkgs, ...}:

{
  # Enable steam hardware support
  hardware.steam-hardware.enable = true;

  # Enable Steam program and open firewall
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Enable gamemode
  programs.gamemode.enable = true;

  # Enable real-time audio/gaming priority
  security.rtkit.enable = true;
}