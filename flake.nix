{
  description = "NixOS";

  inputs = { 
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";

    mac-style.url = "github:SergioRibera/s4rchiso-plymouth-theme";
    # helium-flake.url = "github:oxcl/nix-flake-helium-browser"; #Helium Browser opcional

    nixpkgs.follows = "unstable";
  };

  outputs = { 
    self, 
    nixpkgs, 
    home,
    impermanence,
    # helium-flake,
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
              # helium = inputs.helium-flake.packages.${system}.default;
            }
          )
        ];
  in
  {
    nixosConfigurations = {

      utm-aarch64 = import ./hosts/vm-aarch64/utm.nix { 
        inherit config home inputs nixpkgs overlays;
      };
    };

    utm-aarch64 = self.nixosConfigurations.utm.config.system.build.toplevel;
  };
}
