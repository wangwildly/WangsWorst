 # /etc/nixos/modules/system.nix
 { config, pkgs, ...}:

{  
  # === BOOT & KERNEL ===
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3; # Faster boot menu
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # Enable some useful kernel modules
    kernelModules = [ "kvm-amd" ];
  };

  # === SECURITY (System-wide) ===
  security.polkit.enable = true;

  # === SYSTEM-LEVEL PROGRAMS ===
  programs.dconf.enable = true; # Needed for some apps

  # === NIX SETTINGS ===
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      # Parallel builds for faster compilation
      max-jobs = "auto";
      cores = 0; # 0 = Use all cores, recommended
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}