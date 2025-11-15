{
  description = "J's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #MangoWC
    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  
  outputs = { self, nixpkgs, home-manager, mangowc, ... }: {

    # === NixOS Hosts ===
    nixosConfigurations = {

      # --- Desktop ---
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          ./hosts/desktop.nix
          mangowc.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j = import ./home-j.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

    }; # Closes nixosConfigurations

    # === Formatter ===
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

  }; # Closes outputs
} # Closes the entire file
