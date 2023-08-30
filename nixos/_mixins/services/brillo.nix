{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.brillo
  ];

  # smooth backlight control
  hardware.brillo.enable = true;
  # brillo -A 5 (up)
  # brillo -U 5 (down)
}
