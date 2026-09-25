{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waterfox.url = "github:iolite312/nix-waterfox";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dank-greeter = {
      url = "github:AvengeMedia/dank-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations.maniac = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.iolite = import ./home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
