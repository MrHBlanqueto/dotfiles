{ config, pkgs, ... }:

{
  imports =
    [
      ./daemons.nix
      ./interface.nix
  ];
}
