{ config, pkgs, ... }:

{
  # Adding allow unfree here for proprietary driver
  nixpkgs.config.allowUnfree = true;

hardware.scanbd.enable = true;

  environment.systemPackages = [
    pkgs.brlaser
    pkgs.brscan5
  ];

  # Printing and network printer discovery
  services.printing = {
    enable = true;
    browsing = true; # Find network printer
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };  
}