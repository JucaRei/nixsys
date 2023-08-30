{
  lib,
  pkgs,
  ...
}: {
  imports =
    [
      ./console.nix
      ./fonts.nix
      ./fhs.nix
      ./fhs-fonts.nix
      ./flatpak.nix
      ./fwupd.nix
      ./envpkgs.nix
      ./locales.nix
      ./kmscon.nix
      ./timezone.nix
    ]
    ++ lib.optionals (pkgs.system == "x86_64-linux");

  #######################
  # Shared Boot Options #
  #######################
  boot = {
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
    };
    kernelModules = [
      "vhost_vsock"
      # "kvm-intel"
      # "tcp_bbr"
    ];
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    kernel = {
      sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;

        ### Improve networking
        # https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
        "kernel.sysrq" = 1;
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.default_qdisc" = "cake";
        #"net.core.default_qdisc" = "fq";

        # Bypass hotspot restrictions for certain ISPs
        "net.ipv4.ip_default_ttl" = 65;
      };
    };
  };

  #########################
  # Default Documentation #
  #########################

  documentation = {
    enable = true;
    nixos.enable = false;
    man.enable = true;
    info.enable = false;
    doc.enable = false;
  };

  ###################
  # Base Networking #
  ###################

  networking = {
    extraHosts = ''
      192.168.192.40  skull-zt
      192.168.192.59  trooper-zt
      192.168.193.59  trooper-gaming
      192.168.192.104 steamdeck-zt
      192.168.193.104 steamdeck-gaming
      192.168.192.181 zed-zt
      192.168.192.220 ripper-zt
      192.168.193.220 ripper-gaming
      192.168.192.162 p1-zt
      192.168.192.249 p2-max-zt
      #192.168.192.0   brix-zt
      #192.168.192.0   nuc-zt
      #192.168.192.0   win2-zt
      #192.168.192.0   win-max-zt
    '';
  };
}
