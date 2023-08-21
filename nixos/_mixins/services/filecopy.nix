{
  desktop,
  hostname,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      aria2
      croc
      rclone
      wget2
      wormwhole-william
      zsync
    ]
    ++ lib.optionals (desktop != null) [
      localsend
      # persepolis
      motrix
    ];
  services = {
    aria2 = {
      enable = true;
      openPorts = true;
      rpcSecret = "${hostname}";
    };
    croc = {
      enable = true;
      pass = "${hostname}";
      openFirewall = true;
    };
  };
}
