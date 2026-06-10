{ config, pkgs, lib, inputs, ... }:

{
  home = {
    username = "humbe";
    homeDirectory = "/home/humbe";

    file = {
        ".config/wezterm/wezterm.lua".text = import ./config/wezterm.nix { };
        ".config/starship.toml".text = import ./config/starship.nix { };
      };

    sessionVariables = {
      #BROWSER = "${pkgs.brave}/bin/brave";
      #EDITOR = "${config.programs.nixvim.package}/bin/nvim";
      #GOPATH = "${config.home.homeDirectory}/Extras/go";
      #QT_QPA_PLATFORMTHEME = "qt5ct";
      #RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";

      SDL_VIDEODRIVER = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM="wayland;xcb";
      QT_QPA_PLATFORMTHEME="gnome";
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

    /*''helium = {
      enable = false;
      flags = [
        "--ozone-platform-hint=auto"
      ];

      package = inputs.helium-flake.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {
            src = oldAttrs.src.overrideAttrs (oldSrcAttrs: {
              outputHash = "sha256-ESKv+yIyYJJfJd785w/vIgaPE4OTNulE5i4cN/RtDDY=";
            });
          });''
        }; */
    
    brave = {
      enable = true;
      package = pkgs.brave;
    };

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

    fish = {
      enable = true;

      # Desactivate Greeting.
      interactiveShellInit = ''
        set -g fish_greeting 
        set -g fish_color_command --bold blue
        set -g fish_color_param --bold cyan
        set -g fish_color_valid_path --bold green
        set -g fish_color_quote --bold yellow
        set -g fish_color_end --bold magenta

        set -g fish_color_pager_prefix --bold cyan
        set -g fish_color_pager_description --bold yellow""'';

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