{ config, inputs, nixpkgs, home, overlays, ... }:

nixpkgs.lib.nixosSystem rec {

  modules = [
    home.nixosModules.home-manager
    nixpkgs.nixosModules.notDetected

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