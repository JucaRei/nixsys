{ pkgs, ... }:
let 
skim-cmds = {
  projects = "fd '.git$' ~ -I -t d -t f -d 3 -H -x dirname | sk | tr -d '\n'";
  files = "fd '.*' '.' --hidden -E '.git*' | sk";
  history = "history | sk --tac --no-sort | awk '{$1=\"\"}1'";
  rg = "sk --ansi -i -c 'rg --color=never --line-number \"{}\" .'";
};
in {
  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyFile = "\$HOME/.bash_history";
    historyFileSize = 40000;
    historyIgnore = [ "ls" "cd" "exit" "kill" "htop" "top" "btop" "btm" "neofetch" ];
    historySize = 40000;

    shellAliases = {
      ls = "exa -Slhg --icons";
      lsa = "exa -Slhga --icons";
      o = "xdg-open";
      gc = "git commit -v -S";
      gst = "git status --short";
      ga = "git add";
      gd = "git diff --minimal";
      gl = "git log --oneline --decorate --graph";
    };

    shellOptions = [
      "histappend"         # Append to history file rather than replacing it.
      "autocd"
      "extglob"            # Extended globbing.
      "globstar"
      "dotglob"
      "checkwinsize"       # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
      "cdspell"
      "dirspell"
      "expand_aliases"
      "gnu_errfmt"
      "histreedit"
      "nocasematch"
    ];
    initExtra = ''
      projects () {
        local proj="$(${skim-cmds.projects})"
        [ "" != "$proj" ] && echo ${tm "$proj"}
      }
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
    ''
  };
}