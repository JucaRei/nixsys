{ lib, modulesPath, pkgs, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./disks.nix { })
    ../_mixins/hardware/boot/efi.nix
    ../_mixins/services/security/sudo.nix
  ];

  boot = {

    isContainer = false;

    initrd = {
      availableKernelModules = [
        "ahci"
        "xhci_pci"
        "virtio_pci"
        "sr_mod"
        "virtio_blk"
      ];

      ### kernel modules to be loaded in the second stage, that are needed to mount the root file system ###
      kernelModules = [
        "zswap.compressor=z3fold"
        "z3fold"
        "crc32c-intel"
        "zswap.zpool=lz4hc"
        "lz4hc_compress"
        "nomodeset"
        #"video=hyperv_fb:1920x1080"
        #"kvm-intel"
      ];
      checkJournalingFS = false; # for vm
      supportedFilesystems = [ "xfs" ];
      verbose = false;
    };
    kernelPackages = pkgs.linuxPackages_latest;

    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 500;
      "vm.swappiness" = 20;
      "vm.dirty_background_ratio" = 1;
      "vm.dirty_ratio" = 50;
      "vm.overcommit_memory" = "1";
    };

    plymouth = {
      theme = "breeze";
      enable = true;
    };

    loader = {
      efi = {
        canTouchEfiVariables = lib.mkForce false;
        efiSysMountPoint = "/boot";
      };
      timeout = 5;

      grub = {
        gfxmodeEfi = lib.mkForce "auto";
        fontSize = 20;

        configurationName = lib.mkForce "NixOS HyperV test";
      };
    };
  };

  zramSwap = {
    enable = true;
    swapDevices = 5;
    memoryPercent = 125; # 20% of total memory
    algorithm = "zstd";
  };


  services.xserver = {
    modules = with pkgs; [
      xrdp
      xorg.xf86videofbdev
    ];
    videoDrivers = [ "hyperv_fb" ];
    layout = lib.mkForce "br";
    exportConfiguration = true;
    dpi = 96;
    logFile = "/var/log/Xorg.0.log";
  };

  environment.systemPackages = with pkgs; [
    #linuxKernel.packages.linux_6_1.vm-tools
    powershell
    python3Full
    #python.pkgs.pip
    #terminus-nerdfont
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1u" "python-2.7.18.6" ];
}
