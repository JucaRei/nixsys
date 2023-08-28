{
  desktop,
  lib,
  ...
}: {
  imports =
    []
    ++ lib.optionals (desktop != null) [
      ../apps/keybase.nix
    ];

  services = {
    kbfs = {
      enable = true;
      mountPoint = "Keybase";
    };
  };
}
