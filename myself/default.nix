{ config, pkgs, lib, inputs, ... }:

{
home = {
    username = "humbe";
    homeDirectory = "/home/humbe";

    file = {
        ".config/wezterm/wezterm.lua".text = import ./config/wezterm.nix { };
      };

    sessionVariables = {
      #BROWSER = "${pkgs.brave}/bin/brave";
      #EDITOR = "${config.programs.nixvim.package}/bin/nvim";
      #GOPATH = "${config.home.homeDirectory}/Extras/go";
      #QT_QPA_PLATFORMTHEME = "qt5ct";
      #RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";

      SDL_VIDEODRIVER = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      MOZ_ENABLE_WAYLAND = "1";
      CLUTTER_BACKEND = "wayland";
      NO_AT_BRIDGE = "1";
    };

    packages = with pkgs; [
      vscode
      wezterm
      nautilus
      telegram-desktop
      #libreoffice-fresh
      #gnome-tweaks
    
      fastfetch
      eza

      twitter-color-emoji
      nerd-fonts.ubuntu-sans
      nerd-fonts.ubuntu-mono

      # x86_64
      # onlyoffice-desktopeditors
    ];

    stateVersion = "26.05";
  };

  programs = {

    git = {
      enable = true;
      userName  = "HBlanqueto";
      userEmail = "mc4w6wmkrv@privaterelay.appleid.com";
    };

    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "full";
        theme = "base16";
      };
    };

    brave = {
      enable = true;
      package = pkgs.brave;
    };

    fish = {
      enable = true;

      # Desactivate Greeting.
      interactiveShellInit = ''set -g fish_greeting ""'';

      shellAliases = {
        nix-update = "sudo nixos-rebuild switch";
        flake-update = "sudo nixos-rebuild switch --flake .#NixOS";
        g = "git";
        c = "clear";
        ls = "eza --color=auto --icons";
        l = "ls -l";
        la = "ls -a";
        lla = "ls -la";
        lt = "ls --tree";
  };
    };

    starship = {
      enable = true;
      settings = import ./config/starship.nix;
    };

      home-manager = {
      enable = true;
      path = "…";
    };
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
}