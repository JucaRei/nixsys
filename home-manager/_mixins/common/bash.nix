{pkgs, ...}: let
  skim-cmds = {
    files = "fd '.*' '.' --hidden -E '.git*' | sk";
    history = "history | sk --tac --no-sort | awk '{$1=\"\"}1'";
    rg = "sk --ansi -i -c 'rg --color=never --line-number \"{}\" .'";
  };
in {
  imports = [
    ../../../resources/bash/aliases-home.nix
  ];
  config.programs.bash = {
    enable = true;
    enableVteIntegration = true;
    historyControl = ["erasedups" "ignoredups" "ignorespace"];
    historyFile = "\$HOME/.bash_history";
    historyFileSize = 40000;
    historyIgnore = ["ls" "cd" "exit" "kill" "htop" "top" "btop" "btm" "neofetch"];

    shellAliases = {
      #ls = "exa -Slhg --icons";
      #lsa = "exa -Slhga --icons";
      # ls = "exa -Slhg --icons";
      # ll = "exa -l";
      # la = "exa -a";
      # lt = "exa --tree";
      # lla = "exa -la";
      o = "xdg-open";
      gc = "git commit -v -S";
      gst = "git status --short";
      ga = "git add";
      gd = "git diff --minimal";
      gl = "git log --oneline --decorate --graph";
    };

    shellOptions = [
      "histappend"
      "autocd"
      "globstar"
      "checkwinsize"
      "cdspell"
      "dirspell"
      "expand_aliases"
      "dotglob"
      "gnu_errfmt"
      "histreedit"
      "nocasematch"
    ];

    initExtra = ''
      skim-files () {
        echo $(${skim-cmds.files})
      }
      skim-history () {
        echo $(${skim-cmds.history})
      }
      skim-rg () {
        echo $(${skim-cmds.rg})
      }
    '';

    bashrcExtra = ''
      # -------===[ External Plugins ]===------- #
      eval "$(starship init bash)"
      eval "$(direnv hook bash)"
    '';
  };
}
