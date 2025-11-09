# /etc/nixos/modules/networking.nix
{ config, pkgs, ...}:

{
  # === NETWORKING ===
  networking = {
    hostName = "nixos"; # <-- If changing, match this in flake.nix
    networkmanager.enable = true;
    # Enable firewall by default (security)
    firewall.enable = true;
  };
}