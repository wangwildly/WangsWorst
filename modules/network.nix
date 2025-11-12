# /etc/nixos/modules/networking.nix
{ config, pkgs, ...}:

{
  # === NETWORKING ===
  networking = {
    # hostName = "nixos"; # <-- This is now handled by each machines respective host file
    networkmanager.enable = true;
    # Enable firewall by default (security)
    firewall = {
      enable = true;

    # Deskflow
     allowedTCPPorts = [ 24800 ];

    };
  };
}
