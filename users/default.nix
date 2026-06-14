{ config, pkgs, inputs, lib, ... }:

let
  theme = import ../theme { };
in

{
  imports = [
    ./config/ncmpcpp.nix
  ];

  home = {
    username = "humbe";
    homeDirectory = "/home/humbe";

    sessionVariables = {
      BROWSER = "${pkgs.firefox}/bin/firefox";
      TERMINAL = "wezterm";

      SDL_VIDEODRIVER = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM="wayland;xcb";
      QT_QPA_PLATFORMTHEME="gnome"; # or "qt5ct"
      CLUTTER_BACKEND = "wayland";
      NO_AT_BRIDGE = "1";
    };


    packages = with pkgs; [
      fastfetch
      eza
      ffmpeg

      python3

      vscode
      wezterm
      nautilus
      telegram-desktop
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

    yazi = {
      enable = true;

      settings = {
        yazi = {
          ratio = [ 1 4 3 ];
          sort_by = "natural";
          sort_sensitive = true;
          sort_reverse = false;
          sort_dir_first = true;
          linemode = "none";
          show_hidden = true;
          show_symlink = true;
        };

      preview = {
        image_preview_protocol = "iterm2"; 
      
        image_filter = "lanczos3";
          image_quality = 90;
          tab_size = 1;
          max_width = 600;
          max_height = 900;
          cache_dir = "";
      };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
        };
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
        set -g fish_color_command --bold green""'';

      shellAliases = {
        delgen = "sudo nix-collect-garbage --delete-older-than 1d && sudo nix-store --gc && sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old";
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
      settings = import ./config/starship.nix;
    };

    home-manager = {
      enable = true;
    };
  };

  services = {
    mpd = {
      enable = true;
      package = pkgs.mpd;
      musicDirectory = config.xdg.userDirs.music;
      playlistDirectory = "${config.home.homeDirectory}/.config/mpd/playlists";
      dataDir = "${config.home.homeDirectory}/.config/mpd";
      extraConfig = import ./config/mpd.nix { };
    };
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;

    configFile = {
      "wezterm/wezterm.lua".text = import ./config/wezterm.nix { inherit theme; };
    };

    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Documentos";
      music = "${config.home.homeDirectory}/Música";
      pictures = "${config.home.homeDirectory}/Imágenes";
      videos = "${config.home.homeDirectory}/Videos";
      download = "${config.home.homeDirectory}/Descargas";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
}