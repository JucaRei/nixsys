{
  config,
  pkgs,
  lib,
  ...
}:
with lib.hm.gvariant; {
  home.packages = with pkgs; [
    vscode
  ];
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Nix
      bbenoist.nix
      kamadorueda.alejandra
      jnoortheen.nix-ide

      # Conf
      naumovs.color-highlight
      oderwat.indent-rainbow
      tombonnike.vscode-status-bar-format-toggle
      eamodio.gitlens
      natqe.reload
      christian-kohler.path-intellisense
      foxundermoon.shell-format
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.vscode-remote-extensionpack

      # Themes
      repeale.material-monokai
      cfigueiroa.material-icon-theme-plus
      vscode-icons-team.vscode-icons
    ];
    userSettings = {
      "editor.fontSize" = false;
      "editor.fontLigatures" = true;
      "editor.minimap.maxColumn" = 100;
      "editor.minimap.autohide" = true;
      "terminal.integrated.fontSize" = 17;
      "git.autofetch" = true;
      "workbench.productIconTheme" = "material-product-icons";
      "workbench.colorTheme" = "Material Monokai High Contrast";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "diagnostics" = {
            "ignored" = [
              "unused_binding"
              "unused_with"
            ];
          };
          "formatting" = {
            "command" = [
              "alejandra"
            ];
          };
        };
      };
    };
  };
}
