{pkgs, ...}: {
  home = {
    packages = with pkgs; [kitty];
  };
  xdg.configFile."kitty/kitty.conf".text = import ../../../resources/kitty/kitty.nix;
  xdg.configFile."kitty/themes/lunar.conf".text = import ../../../resources/kitty/lunar.nix;
}
