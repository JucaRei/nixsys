{
  inputs,
  outputs,
  stateVersion,
  ...
}: let
  platforms = [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
in {
  # Helper function for generating home-manager configs
  mkHome = {
    hostname,
    username,
    desktop ? null,
    platform ? platforms,
    # platform ? "aarch64-linux",
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit inputs outputs desktop hostname platform username stateVersion;
      };
      modules = [
        #inputs.nix-index-database.hmModules.nix-index
        #{programs.nix-index-database.comma.enable = true;}
        ../home-manager
      ];
    };

  # Helper function for generating host configs
  mkHost = {
    hostname,
    username,
    desktop ? null,
    installer ? null,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs desktop hostname username stateVersion;
      };
      modules =
        [
          ../nixos
          inputs.agenix.nixosModules.default
        ]
        ++ (inputs.nixpkgs.lib.optionals (installer != null) [installer]);
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
