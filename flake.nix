{
  description = "J's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  
  outputs = { self, nixpkgs, home-manager, ... }: {

    # === NixOS Hosts ===
    nixosConfigurations = {

      # --- Desktop ---
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          ./hosts/desktop.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j = import ./home-j.nix;
          }
        ];
      };

      # --- Laptop ---
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          ./hosts/laptop.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ju = import ./home-ju.nix;
          }
        ];
      };
    }; # Closes nixosConfigurations

    # === Formatter ===
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

  }; # Closes outputs
} # Closes the entire file
