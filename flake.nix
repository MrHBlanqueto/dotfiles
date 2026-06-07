{
  description = "NixOS";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home.url = "github:nix-community/home-manager";

    mac-style.url = "github:SergioRibera/s4rchiso-plymouth-theme";

    nixpkgs.follows = "unstable";
  };

  outputs = { 
    self, 
    nixpkgs, 
    home,
    ... 
  }@inputs:
  with nixpkgs.lib;
  let
    config = {
      allowBroken = true;
      allowUnfree = true;
    };

  filterNixFiles = k: v: v == "regular" && hasSuffix ".nix" k;

  importNixFiles = path:
    (lists.forEach (mapAttrsToList (name: _: path + ("/" + name))
      (filterAttrs filterNixFiles (builtins.readDir path)))) import;

  overlays = with inputs;
          [
            (final: _:
              let system = final.stdenv.hostPlatform.system;
              in {
              # Packages provided by flake inputs
              mac-style-plymouth = mac-style.packages.${system}.default;
            }
          )
        ];
  in
  {
    nixosConfigurations.NixOS = import ./core { 
      inherit config home inputs nixpkgs overlays;
    };

    NixOS = self.nixosConfigurations.NixOS.config.system.build.toplevel;
  };
}
