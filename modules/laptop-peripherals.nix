{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.brlaser
    pkgs.brscan5
    pkgs.brscan-skey    
  ];

  # Printing and network printer discovery
  services.printing = {
    enable = true;
    browsing = true; # Find network printer
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
}