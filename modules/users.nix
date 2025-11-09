# /etc/nixos/modules/users.nix
{ config, pkgs, ... }:

{
  users.users.j = {
    isNormalUser = true;
    description = "j";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "gamemode" ];
    packages = [
      # User-specific packages are best in home-manager,
      # they would go here with pkgs. prefix
    ];
  };
}