{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin-mocha";
    };
    themes = {
      # cyberpunk-neon =
      # builtins.readFile ./assets/bat/themes/cyberpunk-neon.tmTheme;
      Catppuccin-mocha =
        builtins.readFile ./assets/bat/themes/Catppuccin-mocha.tmTheme;
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch
      prettybat
    ];
  };
  systemd.user.services.bat-cache = {
    Unit.Description = "Build and update bat cache";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bat}/bin/bat cache --build";
    };
    Install.WantedBy = ["default.target"];
  };
}
