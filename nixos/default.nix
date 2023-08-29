{
  config,
  desktop,
  hostname,
  inputs,
  lib,
  modulesPath,
  outputs,
  pkgs,
  stateVersion,
  username,
  ...
}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.vscode-server.nixosModules.default
      (modulesPath + "/installer/scan/not-detected.nix")
      ./${hostname}
      ./_mixins/services/firewall.nix
      ./_mixins/services/filecopy.nix
      ./_mixins/services/fwupd.nix
      ./_mixins/services/kmscon.nix
      ./_mixins/services/openssh.nix
      ./_mixins/services/smartmon.nix
      ./_mixins/users/root
      ./_mixins/users/${username}
    ]
    ++ lib.optional (builtins.isString desktop) ./_mixins/desktop;

  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelModules = ["vhost_vsock"];
    kernelParams = [
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };

  # Use passed hostname to configure basic networking
  networking = {
    extraHosts = ''
      192.168.1.35  nitro
      192.168.1.50  nitro
      192.168.1.76  rocinante
      192.168.1.45  rocinante
      192.168.1.228 rocinante
      192.168.1.230 air

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
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      inputs.agenix.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Accept the joypixels license
      joypixels.acceptLicense = true;
    };
  };

  nix = {
    checkConfig = true;
    checkAllErrors = true;

    # 🍑 smooth rebuilds
    # Reduce disk usage
    daemonIOSchedClass = "idle";
    # Leave nix builds as a background task
    daemonCPUSchedPolicy = "idle";
    #daemonIOSchedPriority = 2; # 7 max

    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "00:00";
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    optimise.automatic = true;
    package = pkgs.unstable.nix;
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

      # Avoid unwanted garbage collection when using nix-direnv
      keep-outputs = true;
      keep-derivations = true;

      # Continue build
      keep-going = true;

      warn-dirty = false;
    };

    extraOptions = ''
      log-lines = 15

      # Free up to 4GiB whenever there is less than 1GiB left.
      min-free = ${toString (1024 * 1024 * 1024)}
      # Free up to 4GiB whenever there is less than 512MiB left.
      #min-free = ${toString (512 * 1024 * 1024)}
      max-free = ${toString (4096 * 1024 * 1024)}
      #min-free = 1073741824 # 1GiB
      #max-free = 4294967296 # 4GiB
      #builders-use-substitutes = true

      connect-timeout = 5
    '';
  };

  programs = {
    command-not-found.enable = false;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_cursor_default block blink
        set fish_cursor_insert line blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual block
        set -U fish_color_autosuggestion brblack
        set -U fish_color_cancel -r
        set -U fish_color_command green
        set -U fish_color_comment brblack
        set -U fish_color_cwd brgreen
        set -U fish_color_cwd_root brred
        set -U fish_color_end brmagenta
        set -U fish_color_error red
        set -U fish_color_escape brcyan
        set -U fish_color_history_current --bold
        set -U fish_color_host normal
        set -U fish_color_match --background=brblue
        set -U fish_color_normal normal
        set -U fish_color_operator cyan
        set -U fish_color_param blue
        set -U fish_color_quote yellow
        set -U fish_color_redirection magenta
        set -U fish_color_search_match bryellow '--background=brblack'
        set -U fish_color_selection white --bold '--background=brblack'
        set -U fish_color_status red
        set -U fish_color_user brwhite
        set -U fish_color_valid_path --underline
        set -U fish_pager_color_completion normal
        set -U fish_pager_color_description yellow
        set -U fish_pager_color_prefix white --bold --underline
        set -U fish_pager_color_progress brwhite '--background=cyan'
      '';
      shellAbbrs = {
        nix-gc = "sudo nix-collect-garbage --delete-older-than 10d && nix-collect-garbage --delete-older-than 10d";
        rebuild-all = "sudo nix-collect-garbage --delete-older-than 10d && nix-collect-garbage --delete-older-than 10d && sudo nixos-rebuild switch --flake $HOME/Zero/nixsys && home-manager switch -b backup --flake $HOME/Zero/nixsys";
        rebuild-home = "home-manager switch -b backup --flake $HOME/Zero/nixsys";
        rebuild-host = "sudo nixos-rebuild switch --flake $HOME/Zero/nixsys";
        rebuild-lock = "pushd $HOME/Zero/nixsys && nix flake update && popd";
        rebuild-iso-console = "sudo true && pushd $HOME/Zero/nixsys && nix build .#nixosConfigurations.iso-console.config.system.build.isoImage && set ISO (head -n1 result/nix-support/hydra-build-products | cut -d'/' -f6) && sudo cp result/iso/$ISO ~/Quickemu/nixos-console/nixos.iso && popd";
        rebuild-iso-desktop = "sudo true && pushd $HOME/Zero/nixsys && nix build .#nixosConfigurations.iso-desktop.config.system.build.isoImage && set ISO (head -n1 result/nix-support/hydra-build-products | cut -d'/' -f6) && sudo cp result/iso/$ISO ~/Quickemu/nixos-desktop/nixos.iso && popd";
        rebuild-iso-gpd-edp = "sudo true && pushd $HOME/Zero/nixsys && nix build .#nixosConfigurations.iso-gpd-edp.config.system.build.isoImage && set ISO (head -n1 result/nix-support/hydra-build-products | cut -d'/' -f6) && sudo cp result/iso/$ISO ~/Quickemu/nixos-gpd-edp.iso && popd";
        rebuild-iso-gpd-dsi = "sudo true && pushd $HOME/Zero/nixsys && nix build .#nixosConfigurations.iso-gpd-dsi.config.system.build.isoImage && set ISO (head -n1 result/nix-support/hydra-build-products | cut -d'/' -f6) && sudo cp result/iso/$ISO ~/Quickemu/nixos-gpd-dsi.iso && popd";
      };
      shellAliases = {
        moon = "curl -s wttr.in/Moon";
        nano = "micro";
        open = "xdg-open";
        pubip = "curl -s ifconfig.me/ip";
        #pubip = "curl -s https://api.ipify.org";
        wttr = "curl -s wttr.in && curl -s v2.wttr.in";
        wttr-bas = "curl -s wttr.in/basingstoke && curl -s v2.wttr.in/basingstoke";
      };
    };
  };

  systemd = {
    tmpfiles.rules = [
      "d /nix/var/nix/profiles/per-user/${username} 0755 ${username} root"
      "d /mnt/snapshot/${username} 0755 ${username} users"
    ];
    # Change systemd stop job timeout in NixOS configuration (Default = 90s)
    services.NetworkManager-wait-online.enable = false;
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  system = {
    activationScripts.diff = {
      supportsDryActivation = true;
      text = ''
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
      '';
      fixboot.text = ''
        ln -sfn "$(readlink -f "$systemConfig")" /run/current-system
      '';
    };

    autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L" #print build logs
      ];
      dates = "monthly";
      randomizedDelaySec = "45min";
    };

    stateVersion = stateVersion;
  };
}
