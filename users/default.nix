{ config, pkgs, inputs, lib, ... }:

let
  theme = import ../theme { };
in

{
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

      plugins = {
        inherit (pkgs.yaziPlugins) 
          full-border
          yatline;
      };

      theme = {
        mgr = {
          border_style = { fg = "black"; };
        };
        header = {
          overall = { fg = "white"; bg = "black"; };
        };
        status = {
          overall = { fg = "white"; bg = "black"; };
        };
      };

      initLua = ''
        -- Activamos el borde exterior redondeado
        require("full-border"):setup {
          type = ui.Border.ROUNDED,
        }

        -- Configuramos Yatline para encapsular el Header y el Status
        require("yatline"):setup {
        	section_separator = { open = "", close = "" },
	        part_separator = { open = "", close = "" },
	        inverse_separator = { open = "", close = "" },
          -- DISEÑO DEL HEADER (Parte Superior)
          header = {
            -- Ponemos la sección de la ruta (header_a) dentro de una cápsula
            header_a = {
              components = { "colored_path" },
              fg = "cyan",
              bg = "black",
              style = "bold",
            },
            -- Las pestañas al lado de forma sutil
            header_b = {
              components = { "tabs" },
              fg = "darkgray",
              bg = "black",
            }
          },

          -- DISEÑO DEL STATUS (Parte Inferior)
          status = {
            status_a = {
              components = { "mode" },
              fg = "cyan",
              bg = "black",
              style = "bold",
            },
            status_b = {
              components = { "permissions" },
              fg = "green",
              bg = "black",
              style = "bold",
            },
            status_c = {
              components = { "percentage" },
              fg = "magenta",
              bg = "black",
              style = "bold",
            }
          }
        }
      '';
    };

    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override { visualizerSupport = true; };
      settings = import ./config/ncmpcpp.nix;
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
    mopidy = {
      enable = true;

      extensionPackages = with pkgs; [
        mopidy-local
        mopidy-mpd
      ];

      settings = import ./config/mopidy.nix { };
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
      desktop = "${config.home.homeDirectory}/Escritorio";
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