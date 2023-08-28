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
    packages = with pkgs; [
      neofetch # Terminal system info
      duf # Modern Unix `df`
      du-dust # Modern Unix `du`
      util-linux # for small systems
    ];

    sessionVariables = {
      EDITOR = "micro";
      MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man'";
      PAGER = "moar";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
    shellAliases = {
      ### Nix ###
      rebuild-home = "home-manager switch -b backup --flake $HOME/Zero/nixsys";
      rebuild-lock = "pushd $HOME/Zero/nixsys && nix flake lock --recreate-lock-file && popd";
      nix-clean = "nix-collect-garbage -d";
      rebuild-iso-console = "pushd $HOME/Zero/nixsys && nix build .#nixosConfigurations.iso-console.config.system.build.isoImage && popd";
      rebuild-iso-desktop = "pushd $HOME/Zero/nixsys && nix build .#nixosConfigurations.iso-desktop.config.system.build.isoImage && popd";
      nix-hash-sha256 = "nix-hash --flat --base32 --type sha256";
    };
  };

  programs = {
    home-manager.enable = true;
    info.enable = true;
    nix-index.enable = true;
  };
}
