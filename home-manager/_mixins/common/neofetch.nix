{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [neofetch];
    file = {
      "${config.xdg.configHome}/neofetch/config.conf".text = builtins.readFile ../../../resources/neofetch/neofetch.conf;
    };
  };
}
