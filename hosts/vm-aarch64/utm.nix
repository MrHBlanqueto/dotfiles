{ inputs, nixpkgs, home, config, overlays, ... }:

nixpkgs.lib.nixosSystem rec {
  system = "aarch64-linux";

  modules = [
    home.nixosModules.home-manager
    nixpkgs.nixosModules.notDetected
    inputs.impermanence.nixosModules.impermanence

    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        sharedModules = [ 
          #"${inputs.helium-flake}/modules/home-manager/default.nix"
        ];
        users.humbe = nixpkgs.lib.mkMerge [ ../users ];
      };
      nixpkgs = { inherit config overlays; };
    }
    ../system
      /hardware-configuration.nix
  ];
}