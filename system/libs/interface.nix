{ config, pkgs, ... }:

{
  services = {

    xserver = {
      enable = true;
      wacom.enable = true;

      xkb = {
        layout = "es";
        variant = "";
      };
    };

    displayManager = {
      gdm = {
        enable = true;
      };
    };

    desktopManager = {
      gnome = {
        enable = true;
      };
    };

    gnome = {
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };
  }; 

  environment.gnome.excludePackages = with pkgs; [ ];

  console.keyMap = "es";
}