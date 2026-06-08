{ config, inputs, nixpkgs, home, overlays, ... }:

nixpkgs.lib.nixosSystem rec {

  system = "aarch64-linux";

  modules = [
    home.nixosModules.home-manager
    nixpkgs.nixosModules.notDetected
    
    inputs.impermanence.nixosModules.impermanence

    {
      home-manager = {
        sharedModules = [  ];
        users.humbe = nixpkgs.lib.mkMerge [ ../myself ];
      };

      nixpkgs = { inherit config overlays; };
    }

    ./configuration.nix
  ];

  specialArgs = { inherit inputs; };
}
