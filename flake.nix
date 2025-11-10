outputs = { self, nixpkgs, home-manager, ... }: {

    # === NixOS Hosts ===
    nixosConfigurations = {

      # --- Desktop ---
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          # Main entrypoint for the desktop
          ./hosts/desktop.nix

          # Shared Home-Manager config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j = import ./home.nix;
          }
        ];
      };

      # --- Laptop ---
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          # Main entrypoint for the laptop
          ./hosts/laptop.nix

          # Shared Home-Manager config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j = import ./home.nix;
          }
        ];
      };
    };

    # ... Formatter should be here ...
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
