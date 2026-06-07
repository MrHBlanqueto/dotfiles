# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./ecosystem
      ./hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;

    loader = { 
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth  =  { 
      enable  =  true ; 
      theme = "mac-style";
      themePackages = [ pkgs.mac-style-plymouth ];
    };

    consoleLogLevel = 3; 

    initrd.verbose = false;
    
    kernelParams = [ 
      "quiet" 
      "splash"
      "rd.udev.log_level=3" 
      "rd.systemd.show_status=auto" 
    ];

    kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      "net.core.rmem_max" = 2500000;
      "vm.max_map_count" = 16777216;
      # ZRAM is relatively cheap, prefer swap
      "vm.swappiness" = 100;
      # ZRAM is in memory, no need to readahead
      "vm.page-cluster" = 0;
      # Network
      "net.ipv4.tcp_mtu_probing" = 1;
      "net.ipv4.tcp_fastopen" = 3; # fast recurrent connections
      "net.ipv4.tcp_fin_timeout" = 10;
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_slow_start_after_idle" = 0;
    };
  };

  networking.hostName = "NixOS-VM";

  time.timeZone = "America/Merida";

  i18n.defaultLocale = "es_MX.UTF-8";

  programs.fish.enable = true;

  users ={ 
    defaultUserShell = pkgs.fish;
    mutableUsers = true;

    users."humbe" = {
      isNormalUser = true;
      description = "Humberto B.";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    curl

    polkit_gnome
    gsettings-desktop-schemas
    libnotify

    corefonts
    vista-fonts
    google-fonts
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  documentation.nixos.enable = false;

  system.stateVersion = "26.05";
}
