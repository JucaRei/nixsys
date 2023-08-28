{pkgs, ...}: {
  home.shellAliases = {
    ls = "${pkgs.exa}/bin/exa -Slhg --icons";
    ll = "${pkgs.exa}/bin/exa -l";
    la = "${pkgs.exa}/bin/exa -a";
    lt = "${pkgs.exa}/bin/exa --tree";
    lla = "${pkgs.exa}/bin/exa -la";
  };
}
