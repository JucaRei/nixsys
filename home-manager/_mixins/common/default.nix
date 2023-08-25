{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aria2.nix
    ./atuin.nix
    ./bat.nix
    ./bash.nix
    ./dircolors.nix
    ./direnv.nix
    ./exa.nix
    ./htop.nix
    ./micro.nix
    ./neofetch.nix
    # ./nix-index.nix
    ./nix.nix
    ./nixpkgs.nix
    ./skim.nix
    ./ssh.nix
    ./variables.nix
    ./zoxide.nix
  ];

  home = {
    sessionVariables = {
      EDITOR = "micro";
      MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man'";
      PAGER = "moar";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
  };

  programs = {
    home-manager.enable = true;
    info.enable = true;
    nix-index.enable = true;
  };
}
