{ config, pkgs, lib, inputs, ... }:

{
  home = {
    username = "humbe";
    homeDirectory = "/home/humbe";

    file = {
        ".config/wezterm/wezterm.lua".text = import ./config/wezterm.nix { };
        # ".config/starship.toml".text = import ./config/starship.nix { };
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
      neovim
      vscode
      wezterm
      nautilus
      telegram-desktop
      #libreoffice-fresh
      gnome-tweaks
    
      fastfetch
      eza

      twitter-color-emoji
      nerd-fonts.ubuntu-mono
      nerd-fonts.fira-code
      victor-mono
      
      python3

      # x86_64
      # onlyoffice-desktopeditors
    ];

    stateVersion = "26.05";
  };

  programs = {

    git = {
      enable = true;
      settings = {
        user.email = "mc4w6wmkrv@privaterelay.appleid.com";
        user.name = "MrHBlanqueto";
      };
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
        delgen = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-env --delete-generations old && sudo nix-store --gc";
        nix-update = "sudo nixos-rebuild switch";
        flake-update-rb = "sudo nixos-rebuild boot --flake .#NixOS --impure";
        flake-update-sw = "sudo nixos-rebuild switch --flake .#NixOS --impure";

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