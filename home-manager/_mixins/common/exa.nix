{pkgs, config, lib, ... }: let
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
      mkEnableOption "exa, a modern replacement for <command>ls</command>";
    enableAliases = mkEnableOption "recommended exa aliases";
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--color=always"
    ];
  };
  config = mkIf cfg.enable {
    programs = {
      bash.shellAliases = mkIf cfg.enableAliases aliases;
      fish.shellAliases = mkIf cfg.enableAliases aliases;
      zsh.shellAliases  = mkIf cfg.enableAliases aliases;
    };
  };
}
