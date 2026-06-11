> [!NOTE]
> Currently, this configuration is strictly tested in **UTM** virtual machines running on Apple Silicon hosts (**Mac M4**), targeting the **aarch64** architecture.

**Roadmap & Status**
<img src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fdiscourse.nixos.org%2Fuploads%2Fdefault%2Foriginal%2F3X%2F1%2F9%2F19e239e4966baeeb05ad059568a4d0ad4e275bef.png&f=1&nofb=1&ipt=8b9bb230d581aacab72cdaa307b55a8f20544c537704d42c1577d71aa40f8999" align="right" width="150" alt="NixOS Logo" />

- [x] Migrate to Nix Flakes
- [x] Integrate Home Manager
- [x] Implement Impermanence file system setup
- [ ] Set up Agenix for secrets management
- [ ] Implement ZFS as the primary filesystem instead of Btrfs
- [ ] Set up drive encryption and decryption using Lanzaboote (Secure Boot & Measured Boot)

<br clear="right"/>

## Setup

### Drive Partitioning

```shell
# Temporarily mount the Btrfs disk root to carve out the subvolume structure
mount /dev/[your partition]

# Create decoupled subvolumes
btrfs su cr /mnt/@{rootfs,home,nix,persist,log}

# Capture a pristine snapshot of the empty root for the impermanence
btrfs subvolume snapshot -r /mnt/@rootfs /mnt/@rootfs-blank
umount /mnt

# Mount the actual ephemeral root (@rootfs)
mount -o subvol=@rootfs,noatime,compress=zstd,space_cache=v2 /dev/[your partition] /mnt

# Generate the hierarchical mount points required for the NixOS installation
mkdir -p /mnt/{home,nix,persist,var/log,boot}

# Mount persistent storage, Nix store cache, and system logs into the target hierarchy
mount -o subvol=@home,noatime,compress=zstd,space_cache=v2 /dev/[your partition] /mnt/home
mount -o subvol=@nix,noatime,compress=zstd,space_cache=v2 /dev/[your partition] /mnt/nix
mount -o subvol=@persist,noatime,compress=zstd,space_cache=v2 /dev/[your partition] /mnt/persist
mount -o subvol=@log,noatime,compress=zstd,space_cache=v2 /dev/[your partition] /mnt/var/log
```

### hardware-configuration.nix
**Impermanence** is implemented in this setup (wiping the root filesystem on every boot), NixOS needs to access the persistent storage and log paths *before* mounting the rest of the system. This requires manually modifying the generated configuration.

1. Generate the initial hardware layout profile from the mounted target system:

```shell
# Clone this dotfiles repository
git clone https://github.com/MrHBlanqueto/dotfiles.git --depth 1
cd dotfiles

# Generate the initial hardware layout configuration from the mounted target system
nixos-generate-config --root /mnt

# Copy the newly generated hardware profile into the declarative dotfiles setup
cp /mnt/etc/nixos/hardware-configuration.nix ~/dotfiles

```
Open ~/dotfiles/hardware-configuration.nix and append neededForBoot = true; to both the /persist and /var/log file systems.

> [!IMPORTANT]
> Without `neededForBoot = true;`, the machine will fail to boot because the impermanence modules and system logging services will attempt to load before their underlying Btrfs subvolumes are mounted.

Your file system declarations should match the following structure:

```nix
    fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/5a387e47-22ae-4e1d-81da-b9ac913a48af";
      fsType = "btrfs";
      options = [ "subvol=@persist" "noatime" "compress=zstd" "space_cache=v2" ];
      neededForBoot = true;
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/5a387e47-22ae-4e1d-81da-b9ac913a48af";
      fsType = "btrfs";
      options = [ "subvol=@log" "noatime" "compress=zstd" "space_cache=v2" ];
      neededForBoot = true;
    };
```


### Installation
```
nixos-install --root /mnt --flake '#utm-aarch64' --impure --show-trace

```
