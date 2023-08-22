{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions = lib.mkIf pkgs.stdenv.isDarwin {
          UseKeychain = "yes";
          AddKeysToAgent = "yes";
        };
        identityFile = ["id_ed25519"];
      };
      "DietPi" = {
        hostname = "192.168.1.200";
        forwardAgent = true;
        user = "juca";
      };
    };
  };
}
