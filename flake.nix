{
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
  };
    # ... Formatter should be here ...
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
