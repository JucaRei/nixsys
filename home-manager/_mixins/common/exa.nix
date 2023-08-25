{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.exa;
  aliases = {
    ls = "${pkgs.exa}/bin/exa -Slhg --icons";
    ll = "${pkgs.exa}/bin/exa -l";
    la = "${pkgs.exa}/bin/exa -a";
    lt = "${pkgs.exa}/bin/exa --tree";
    lla = "${pkgs.exa}/bin/exa -la";
  };
in {
  options.programs.exa = {
    enable =
      lib.mkEnableOption "exa, a modern replacement for <command>ls</command>";
    enableAliases = lib.mkEnableOption "recommended exa aliases";
  };

  programs.exa = {
    enable = lib.mkEnableOption true;
    enableAliases = lib.mkEnableOption true;
    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--color=always"
    ];
  };
  config = lib.mkIf cfg.enable {
    programs = {
      bash.shellAliases = lib.mkIf cfg.enableAliases aliases;
      fish.shellAliases = lib.mkIf cfg.enableAliases aliases;
      zsh.shellAliases = lib.mkIf cfg.enableAliases aliases;
    };
  };
}
