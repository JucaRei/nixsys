_: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        configurationLimit = 5;
        enable = true;
        #consoleMode = "max";
        memtest86.enable = true;
      };
      timeout = 5;
    };
  };
}
