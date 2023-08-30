{pkgs, ...}: {
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    # package = pkgs.bluez5-experimental;
    # powerOnBoot = true;
    # disabledPlugins = [ "sap" ];
    # hsphfpd.enable = false;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        # Experimental = true;
        # Class = "0x000100";
        # FastConnectable = true;
        # ControllerMode = "bredr";
        # JustWorksRepairing = "always";
        #Privacy = "device";
      };
    };
  };

  # https://github.com/NixOS/nixpkgs/issues/114222
  # systemd.user.services.telephony_client.enable = false;
}
