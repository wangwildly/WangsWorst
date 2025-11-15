{
  description = "J's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Use the new 'mango' repo ===
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Add 'mango' to the arguments ===
outputs = { self, nixpkgs, home-manager, mango, ... }: {

    # === NixOS Hosts ===
    nixosConfigurations = {

      # --- Desktop ---
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; }; # This is correct
        modules = [
          ./hosts/desktop.nix
          
          mango.nixosModules.mango 

          # --- Home Manager Config ---
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            
            # === Import HM module for user 'j' ===
            home-manager.users.j = {
              imports = [ 
                ./home-j.nix
                mango.hmModules.mango
              ];
            };
          }
          
        ];
      };

    }; # Closes nixosConfigurations

    # === Formatter ===
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

  }; # Closes outputs
}