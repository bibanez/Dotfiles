{
  description = "bibanez's System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        specialArgs = { inherit inputs; };
        
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.bibanez.imports = [ ./machines/laptop.nix ];
          }
        ];
      };
    };
  };
}
# {
#   description = "bibanez's System Config";

#   inputs = {
#     nixpkgs.url = "nixpkgs/nixos-22.11";
#     home-manager.url = "github:nix-community/home-manager/release-22.11";
#     home-manager.inputs.nixpkgs.follows = "nixpkgs";
#   };

#   outputs = { nixpkgs, home-manager, ... }: 
#   let
#     system = "x86_64-linux";

#     pkgs = import nixpkgs {
#       inherit system;
#       config = { allowUnfree = true; };
#     };
    
#     lib = nixpkgs.lib;
    
#   in {
#     nixosConfigurations = {
#       laptop = lib.nixosSystem {
#         inherit system;
        
#         modules = [
#           ./system/configuration.nix
#           home-manager.nixosModules.home-manager
#           {
#             home-manager.useGlobalPkgs = true;
#             home-manager.useUserPackages = true;
#             home-manager.users.bibanez = import ./home.nix;
#           }
#         ];
#       };            
#     };   
#   };
# }
