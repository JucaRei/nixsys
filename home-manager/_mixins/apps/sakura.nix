{
  config,
  pkgs,
  ...
}: {
  home = {
    file = {
      "${config.xdg.configHome}/sakura/sakura.conf".text = builtins.readFile ../common/assets/terminal/sakura/sakura.conf;
    };
    packages = with pkgs; [
      sakura
    ];
  };
}
