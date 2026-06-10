
{ config, pkgs, lib, ... }: 

{
      imports = [
        ./libs/interface.nix
        ./libs/systemd.nix
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        tmp.cleanOnBoot = true;

        loader = { 
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        plymouth = { 
          enable = true; 
          theme = "mac-style";
          themePackages = [ pkgs.mac-style-plymouth ];
        };

        consoleLogLevel = 3; 

        initrd = {
          verbose = false;
          systemd = {
            initrdBin = with pkgs; [ coreutils btrfs-progs findutils ];
        
            services.rollback = {
              description = "Limpieza de la raiz efimera de Btrfs";
              wantedBy = [ "initrd.target" ];
              before = [ "sysroot.mount" ];
              unitConfig.DefaultDependencies = "no";
              serviceConfig.Type = "oneshot";
              script = ''
                mkdir -p /btrfs_tmp
                mount /dev/vda2 /btrfs_tmp

                if [ -e /btrfs_tmp/@rootfs ]; then
                  mkdir -p /btrfs_tmp/old_roots
                  timestamp=$(date "+%Y-%m-%d_%H:%M:%S")
                  mv /btrfs_tmp/@rootfs /btrfs_tmp/old_roots/$timestamp
                fi

                mkdir -p /btrfs_tmp/old_roots
                find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30 -exec btrfs subvolume delete {} \; 2>/dev/null || true
                btrfs subvolume snapshot /btrfs_tmp/rootfs-blank /btrfs_tmp/@rootfs
            
                umount /btrfs_tmp
              '';
            };
          };
        };
        
        kernelParams = [ "quiet" "splash" "rd.udev.log_level=3" "rd.systemd.show_status=auto" ];

        kernel.sysctl = {
          "kernel.nmi_watchdog" = 0;
          "kernel.sched_cfs_bandwidth_slice_us" = 3000;
          "net.core.rmem_max" = 2500000;
          "vm.max_map_count" = 16777216;
          "vm.swappiness" = 100;
          "vm.page-cluster" = 0;
          "net.ipv4.tcp_mtu_probing" = 1;
          "net.ipv4.tcp_fastopen" = 3;
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
      
      environment.persistence."/persist" = {
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/etc/NetworkManager/system-connections"
          "/etc/nixos"
        ];
        files = [
          "/etc/machine-id"
          "/etc/shadow"
          "/etc/passwd"
          "/etc/group"
        ];
      };

      users = { 
        defaultUserShell = pkgs.fish;
        mutableUsers = false;
        users."humbe" = {
          isNormalUser = true;
          description = "Humberto B.";
          extraGroups = [ "networkmanager" "wheel" ];
          createHome = true;
          hashedPassword = "$6$rvI2ZNaKpc69XPeZ$R6iSUJ3l7iYlFc6eJz4pue1cl51d0H0dBNYkJcTm5BddRohQkdCC7sHmS50UczcPKESV//lw0CpO071roxsB21";
        };
      };

      environment.systemPackages = with pkgs; [
        git 
        wget 
        curl
        
        polkit_gnome 
        gsettings-desktop-schemas 
        libnotify
        
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji

        corefonts
        vista-fonts 
      ];

      nixpkgs.config.allowUnfree = true;

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      documentation.nixos.enable = false;

      system.stateVersion = "26.05";
}