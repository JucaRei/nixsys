# Shell for bootstrapping flake-enabled nix and home-manager
# Enter it through 'nix develop' or (legacy) 'nix-shell'
{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      bash-completion
      nix-bash-completions
      git
      alejandra
      #rnix-lsp
      nil

      ### Testing
      neovim
      duf
      neofetch
    ];
    shellHook = ''
      echo "
       ______   _           _
      |  ____| | |         | |
      | |__    | |   __ _  | | __   ___   ___
      |  __|   | |  / _\` | | |/ /  / _ \ / __|
      | |      | | | (_| | |   <  |  __/ \\__ \\
      |_|      |_|  \__,_| |_|\_\  \___| |___/
          "
    '';
  };
}
