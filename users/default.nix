{ config, pkgs, inputs, lib, ... }:

{

  imports = [
    ./config/ncmpcpp.nix
  ];

  home = {
    username = "humbe";
    homeDirectory = "/home/humbe";

    file = {
        ".config/wezterm/wezterm.lua".text = import ./config/wezterm.nix { };
        ".config/starship.toml".text = import ./config/starship.nix { };
      };

    sessionVariables = {
      BROWSER = "${pkgs.firefox}/bin/firefox";
      TERMINAL = "wezterm";

      SDL_VIDEODRIVER = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM="wayland;xcb";
      QT_QPA_PLATFORMTHEME="gnome"; # or "qt5ct"
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
      nerd-fonts.ubuntu-sans
      nerd-fonts.fira-code
      victor-mono
      
      python3

      # x86_64
      # onlyoffice-desktopeditors
    ];

    stateVersion = "26.05";
  };


  programs = {
    brave = {
      enable = true;
      # package = inputs.brave-origin.packages.${pkgs.stdenv.hostPlatform.system}.default;
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

      functions = {
        fish_greeting = {
          body = ''
            set -l log_file "/tmp/.wezterm_last_login"

              if test -f $log_file
            set -l lines (count < $log_file)
    
              if test "$lines" -eq 1
                cat $log_file
              else if test "$lines" -gt 1
            tail -n 2 $log_file | head -n 1
          end
        end
        set -l current_time (env LC_TIME=C date "+%a %b %d %H:%M:%S")
        set -l current_tty (string replace "/dev/" "" (tty))

        echo "Last login: $current_time on $current_tty" >> $log_file
      '';
    };
  };

      # Desactivate Greeting.
      interactiveShellInit = ''
        set -g fish_greeting 
        set -g fish_color_command --bold green""'';

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
    };
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
}