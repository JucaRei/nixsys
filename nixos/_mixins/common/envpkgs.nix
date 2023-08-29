{pkgs, ...}: {
  environment = {
    defaultPackages = with pkgs;
      lib.mkForce [
        gitMinimal
        home-manager
        micro
        rsync
      ];
    systemPackages = with pkgs; [
      ### System
      agenix
      pciutils
      psmisc
      unzip
      usbutils
    ];
    variables = {
      EDITOR = "micro";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
  };
}
