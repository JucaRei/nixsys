{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      alejandra
      any-nix-shell
      cached-nix-shell
      deadnix
      nix-bash-completions
      nix-index
      nix-du
      nixpkgs-fmt
      nurl
      nil
      rnix-lsp
      statix
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
  };

  programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
