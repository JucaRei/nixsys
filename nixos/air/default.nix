# Intel Skull Canyon NUC6i7KYK
{
  inputs,
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.apple-macbook-air-4
    inputs.nixos-hardware.nixosModules.framework
    inputs.nixos-hardware.nixosModules.common-cpu-intel-sandy-bridge
    # (import ./disks.nix { })
    (import ./disks-ext4.nix {})
    (modulesPath + "/installer/scan/not-detected.nix")
    ../_mixins/hardware/boot/efi.nix
    ../_mixins/hardware/bluetooth
    ../_mixins/hardware/backlight/brillo.nix
    ../_mixins/hardware/cpu/intel.nix
    ../_mixins/hardware/graphics/intel-old.nix
    #../_mixins/hardware/power/powersave-top.nix
    ../_mixins/hardware/wifi/broadcom-wifi.nix
    #../_mixins/services/zerotier.nix
    ../_mixins/services/security/sudo.nix
    ../_mixins/services/network/samba.nix
    ../_mixins/services/network/nfs.nix
    ../_mixins/virt/docker.nix
    ../_mixins/virt
  ];

  # disko does manage mounting of / /boot /home, but I want to mount by-partlabel
  ###################
  ### Hard drives ###
  ###################

  # fileSystems."/" = {
  #   device = "/dev/disk/by-partlabel/NIXOS";
  #   fsType = "btrfs";
  #   options = [
  #     "subvol=@"
  #     "rw"
  #     "noatime"
  #     "nodiratime"
  #     "ssd"
  #     "nodatacow"
  #     "compress-force=zstd:5"
  #     "space_cache=v2"
  #     "commit=120"
  #     "discard=async"
  #   ];
  # };

  # fileSystems."/home" = {
  #   device = "/dev/disk/by-partlabel/NIXOS";
  #   fsType = "btrfs";
  #   options = [
  #     "subvol=@home"
  #     "rw"
  #     "noatime"
  #     "nodiratime"
  #     "ssd"
  #     "nodatacow"
  #     "compress-force=zstd:15"
  #     "space_cache=v2"
  #     "commit=120"
  #     "discard=async"
  #   ];
  # };

  # fileSystems."/.snapshots" = {
  #   device = "/dev/disk/by-partlabel/NIXOS";
  #   fsType = "btrfs";
  #   options = [
  #     "subvol=@snapshots"
  #     "rw"
  #     "noatime"
  #     "nodiratime"
  #     "ssd"
  #     "nodatacow"
  #     "compress-force=zstd:15"
  #     "space_cache=v2"
  #     "commit=120"
  #     "discard=async"
  #   ];
  # };

  # fileSystems."/var/tmp" = {
  #   device = "/dev/disk/by-partlabel/NIXOS";
  #   fsType = "btrfs";
  #   options = [
  #     "subvol=@tmp"
  #     "rw"
  #     "noatime"
  #     "nodiratime"
  #     "ssd"
  #     "nodatacow"
  #     "compress-force=zstd:5"
  #     "space_cache=v2"
  #     "commit=120"
  #     "discard=async"
  #   ];
  # };

  # fileSystems."/nix" = {
  #   device = "/dev/disk/by-partlabel/NIXOS";
  #   fsType = "btrfs";
  #   options = [
  #     "subvol=@nix"
  #     "rw"
  #     "noatime"
  #     "nodiratime"
  #     "ssd"
  #     "nodatacow"
  #     "compress-force=zstd:15"
  #     "space_cache=v2"
  #     "commit=120"
  #     "discard=async"
  #   ];
  # };

  #fileSystems."/swap" = {
  #  device = "/dev/disk/by-partlabel/NIXOS";
  #  fsType = "btrfs";
  #  options = [
  #    "subvol=@swap"
  #    #"compress=lz4"
  #    "defaults"
  #    "noatime"
  #  ]; # Note these options effect the entire BTRFS filesystem and not just this volume, with the exception of `"subvol=swap"`, the other options are repeated in my other `fileSystem` mounts
  #};

  #fileSystems."/.swap" = {
  #  device = "/dev/disk/by-uuid/5830e9b3-260b-451c-bfee-2028c64c6199";
  #  fsType = "btrfs";
  #  options = [ "subvol=@swap" "nodatacow" "noatime" ];
  #  neededForBoot = true;
  #};

  # fileSystems."/boot/efi" = {
  #   device = "/dev/disk/by-partlabel/EFI";
  #   fsType = "vfat";
  #   options = [ "defaults" "noatime" "nodiratime" ];
  #   noCheck = true;
  # };

  # swapDevices = [{
  #   device = "/dev/disk/by-partlabel/SWAP";
  #   options = [ "defaults" "noatime" "nodiratime" ];
  ### SWAPFILE
  #device = "/swap/swapfile";
  #size = 2 GiB;
  #device = "/swap/swapfile";
  #size = (1024 * 2); # RAM size
  #size = (1024 * 16) + (1024 * 2); # RAM size + 2 GB

  #device = "/.swap/swapfile";
  #size = 8192;
  # }];

  boot = {
    isContainer = false;

    # kernel.config = {
    #   Z3FOLD = "y";
    #   CRYPTO_LZ4 = "y";
    # };

    # compile kernel with SE Linux support - but also support for other LSM modules
    # kernelPatches = [{
    #   ### Add Selinux?
    #   name = "selinux-config";
    #   patch = null;
    #   extraConfig = ''
    #     ## Enable SELINUX
    #     CONFIG_SECURITY_SELINUX y
    #     CONFIG_SECURITY_SELINUX_BOOTPARAM n
    #     CONFIG_SECURITY_SELINUX_DISABLE n
    #     CONFIG_SECURITY_SELINUX_DEVELOP y
    #     CONFIG_SECURITY_SELINUX_AVC_STATS y
    #     CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE 0
    #     CONFIG_DEFAULT_SECURITY_SELINUX n
    #     CONFIG_HYPERV_TESTING n

    #     ### Memory
    #     CONFIG_HAVE_KERNEL_GZIP=y
    #     CONFIG_HAVE_KERNEL_BZIP2=y
    #     CONFIG_HAVE_KERNEL_LZMA=y
    #     CONFIG_HAVE_KERNEL_XZ=y
    #     CONFIG_HAVE_KERNEL_LZO=y
    #     CONFIG_HAVE_KERNEL_LZ4=y
    #     CONFIG_HAVE_KERNEL_ZSTD=y
    #     CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
    #     CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
    #     CONFIG_ZBUD=y
    #     CONFIG_Z3FOLD=y
    #     CONFIG_ZSMALLOC=y
    #     CONFIG_ZSMALLOC_STAT=y
    #     CONFIG_ZSMALLOC_CHAIN_SIZE=8
    #     CONFIG_ZRAM_DEF_COMP_LZ4HC=y

    #     #
    #     # Compression
    #     #
    #     # CONFIG_CRYPTO_DEFLATE is not set
    #     CONFIG_CRYPTO_LZO=y
    #     # CONFIG_CRYPTO_842 is not set
    #     CONFIG_CRYPTO_LZ4=y
    #     CONFIG_CRYPTO_LZ4HC=y
    #     CONFIG_CRYPTO_ZSTD=y
    #   '';
    # }];

    #plymouth = {
    #  enable = lib.mkForce true;
    #  theme = "breeze";
    #};

    loader = {
      efi = {
        #canTouchEfiVariables = lib.mkDefault true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        #gfxmodeEfi = lib.mkForce "1366x788";
        efiInstallAsRemovable = lib.mkForce true;

        theme =
          pkgs.fetchFromGitHub
          {
            owner = "semimqmo";
            repo = "sekiro_grub_theme";
            rev = "1affe05f7257b72b69404cfc0a60e88aa19f54a6";
            sha256 = "02gdihkd2w33qy86vs8g0pfljp919ah9c13cj4bh9fvvzm5zjfn1";
          }
          + "/Sekiro";

        # theme = pkgs.fetchFromGitHub
        #   {
        #     owner = "Lxtharia";
        #     repo = "minegrub-theme";
        #     rev = "193b3a7c3d432f8c6af10adfb465b781091f56b3";
        #     sha256 = "1bvkfmjzbk7pfisvmyw5gjmcqj9dab7gwd5nmvi8gs4vk72bl2ap";
        #   };

        #   theme =
        #     pkgs.fetchFromGitHub
        #     {
        #       owner = "Patato777";
        #       repo = "dotfiles";
        #       rev = "d6f96fa59327a936d335f01a7295815250f96ff7";
        #       sha256 = "18mra67kd20bld5zxlvb89ik8psr2pj0v9iaizqpd485sywgqwiq";
        #     }
        #     + "/grub/themes/virtuaverse";
        # };

        # theme = pkgs.fetchFromGitHub {
        #   owner = "shvchk";
        #   repo = "fallout-grub-theme";
        #   rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
        #   sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
        # };
      };
    };
    blacklistedKernelModules = lib.mkForce ["nvidia" "nouveau"];
    #extraModulePackages = with config.boot.kernelPackages; [ ];
    #extraModprobeConfig = ''
    #  options i915 enable_guc=2 enable_dc=4 enable_hangcheck=0 error_capture=0 enable_dp_mst=0 fastboot=1 #parameters may differ
    #'';

    initrd = {
      #systemd.enable = true; # This is needed to show the plymouth login screen to unlock luks
      availableKernelModules = ["uhci_hcd" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      verbose = false;
      compressor = "zstd";
      supportedFilesystems = ["vfat" "ext4" "btrfs" "ntfs"];
    };

    kernelModules = [
      "applesmc"
      "i965"
      #"i915"
      "z3fold"
      #"hdapsd"
      "crc32c-intel"
      "lz4hc"
      "lz4hc_compress"
    ];
    kernelParams = [
      # "security=selinux" # tell kernel to use SE Linux
      "hid_apple.swap_opt_cmd=1" # This will switch the left Alt and Cmd key as well as the right Alt/AltGr and Cmd key.
      #"hid_apple.fnmode=2"
      #"hid_apple.swap_fn_leftctrl=1"
      "video.use_native_backlight=1"
      "acpi=force"
      "acpi_backlight=video" # "acpi_backlight=vendor"
      #"i915.force_probe=0116" # Force enable my intel graphics
      #"video=efifb:off" # Disable efifb driver, which crashes Xavier AGX/NX
      #"video=efifb"
      "zswap.enabled=1"
      "zswap.compressor=lz4hc"
      "zswap.max_pool_percent=20"
      "zswap.zpool=z3fold"
      "fs.inotify.max_user_watches=524288"
      #"intel_iommu=igfx_off"
      "net.ifnames=0"
    ];
    kernel.sysctl = {
      #"kernel.sysrq" = 1;
      #"kernel.printk" = "3 3 3 3";
      "dev.i915.perf_stream_paranoid" = 0;
      #"vm.vfs_cache_pressure" = 300;
      #"vm.swappiness" = 25;
      #"vm.dirty_background_ratio" = 1;
      #"vm.dirty_ratio" = 50;
    };
    #kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.linuxPackages_lqx;
    # kernelPackages = pkgs.linuxPackages_zen;
    #kernelPackages = pkgs.linuxPackages_xanmod_stable;
    supportedFilesystems = ["vfat" "ext4" "btrfs"]; # fat 32 and btrfs
  };
  #hardware = {
  #  acpilight.enable = true;
  #};

  #Section "Device"
  #        Identifier "card0"
  #        Driver "intel"
  #        Option "Backlight" "intel_backlight"
  #        BusID "PCI:0:2:0"
  #EndSection

  ### INTEL FIX SCREEN TEARING ###
  environment = {
    etc."X11/xorg.conf.d/20-intel.conf" = {
      text = ''
        Section         "Device"
          Identifier    "Intel Graphics"
          Option        "intel"
          Option        "TearFree"          "true"
          Option        "AccelMethod"       "sna"
          Option        "SwapbuffersWait"   "true"
          Option        "TripleBuffer"      "true"
          Option        "VariableRefresh"   "true"
          Option        "DRI"               "2"
        EndSection
      '';
    };

    variables = {
      VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
    };
  };

  services = {
    #############
    ### Btrfs ###
    #############

    # btrfs = {
    #   autoScrub = {
    #     enable = true;
    #     interval = "weekly";
    #   };
    # };

    ############
    ### GVFS ###
    ############
    gvfs.enable = true;

    # Thunderbolt
    hardware.bolt.enable = true;
    # # Allow usb controllers via HDMI
    # udev.extraRules = ''KERNEL=="hidraw*", ATTRS{idVendor}=="20d6", ATTRS{idProduct}=="a711", MODE="0660", TAG+="uaccess"'';

    ################################
    ### Device specific services ###
    ################################
    mbpfan = {
      enable = true;
      aggressive = true;
      #lowTemp = 56;
      #highTemp = 62;
      #maxTemp = 70;
    };

    xserver.libinput.touchpad = {
      horizontalScrolling = false;
      naturalScrolling = false;
      tapping = true;
      tappingDragLock = false;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # no need to wait interfaces to have an IP to continue booting
  # networking.dhcpd.wait = "background";
  # avoid checking if IP is already taken to boot a few seconds faster
  # dhcpcd.extraConfig = "noarp";
  # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  environment.systemPackages = with pkgs; [
    xorg.xbacklight
    xorg.xrdb
    intel-gpu-tools
    inxi
    #light
    kbdlight

    cifs-utils

    # SElinux
    # policycoreutils is for load_policy, fixfiles, setfiles, setsebool, semodile, and sestatus.
    #policycoreutils
  ];

  # build systemd with SE Linux support so it loads policy at boot and supports file labelling
  #systemd.package = pkgs.systemd.override { withSelinux = true; };

  programs = {
    #kbdlight.enable = true;
    #light.enable = true;
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  security.doas.enable = lib.mkDefault false;

  # virtualisation.docker = {
  #   storageDriver = lib.mkForce "btrfs";
  # };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  ### Load z3fold and lz4

  systemd.services.zswap = {
    description = "Enable ZSwap, set to LZ4 and Z3FOLD";
    enable = true;
    wantedBy = ["basic.target"];
    path = [pkgs.bash];
    serviceConfig = {
      ExecStart = ''        ${pkgs.bash}/bin/bash -c 'cd /sys/module/zswap/parameters&& \
              echo 1 > enabled&& \
              echo 20 > max_pool_percent&& \
              echo lz4hc > compressor&& \
              echo z3fold > zpool'
      '';
      Type = "simple";
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
