{
  description = "J's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Optional but recommended inputs for future expansion
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      # Use your actual hostname instead of "nixos"
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit self; 
        };
        modules = [
          ./configuration.nix
          
          # This line imports the Home-Manager NixOS module
          home-manager.nixosModules.home-manager
          
          # This block configures Home-Manager
          {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.users.j = import ./home.nix;
           }
        ];
      };
    };

    # Useful for `nix fmt`
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}


