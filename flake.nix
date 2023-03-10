{
  description = "bibanez's System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        specialArgs = { inherit inputs; };
        
        modules = [
          ./system/configuration.nix
          ./system/laptop-hardware.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.bibanez.imports = [ 
                ./configs/home.nix 
                ./configs/sway.nix
              ];
            };
          }
        ];
      };

      nixos-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        specialArgs = { inherit inputs; };
        
        modules = [
          ./system/configuration.nix
          ./system/pc-hardware.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.bibanez.imports = [ 
                ./configs/home.nix 
                ./configs/games.nix
                ./configs/i3.nix
              ];
            };
          }
        ];
      };
    };
  };
}
