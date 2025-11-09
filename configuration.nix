{ config, pkgs, ... }:

{ # <-- Beginning of configuration.nix
  imports = [
    # Machine-specific hardware definition
    ./hardware-configuration.nix

    # List individual modules from /etc/nixos/modules to import
    ./modules/system.nix
    ./modules/hardware.nix
    ./modules/network.nix
    ./modules/desktop.nix
    ./modules/gaming.nix
    ./modules/packages.nix
    ./modules/users.nix
  ];



  # === TOP-LEVEL SETTINGS ===
  # === LOCALIZATION ===
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";


    
  # This must be at the end of the root files
  system.stateVersion = "25.05";

}  # <-- End of configuration.nix 