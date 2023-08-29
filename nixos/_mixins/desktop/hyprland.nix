{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.hyperland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    nvidiaPatches = lib.mkDefault true;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    systemPackages = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    variables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
    };
  };

  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          # wayland = true;
        };
        defaultSession = "hyperland";
      };
      # windowManager = {
      #   i3.enable = true;
      #   bspwm = true;
      # };
      desktopManager = {
        xterm.enable = false;
        gnome = {
          enable = true;
        };
      };
    };
  };

  hardware = {
    nvidia = {
      open = true;
      powerManagement.enable = true;
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };
}
