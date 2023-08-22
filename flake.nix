{
  description = "NixOS and Home Manager Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    # nixpkgs-prev = "github:nixos/nixpkgs/nixos-22.11";
    ### You can access packages and modules from different nixpkgs revs at the same time.
    ### See 'unstable-packages' overlay in 'overlays/default.nix'.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";
    nix-formatter-pack.inputs.nixpkgs.follows = "nixpkgs";

    # nix-software-center.url = "github:vlinkz/nix-software-center";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    vscode-server.url = "github:msteen/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    # nix-index-database.url = "github:Mic92/nix-index-database";
    # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # darwin.url = "github:lnl7/nix-darwin/master"; # MacOS Package Management
    # darwin.inputs.nixpkgs.follows = "nixpkgs";

    # nixgl.url = "github:guibou/nixGL";

    # nixos-generators.url = "github:NixOS/nixos-hardware/master";

    # nur.url = "github:nix-community/NUR"; # Add "nur.nixosModules.nur" to the host modules

    # spicetify-nix.url = "github:the-argus/spicetify-nix";
    # nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    # wallpaper-generator.url = "github:pinpox/wallpaper-generator";
    # wallpaper-generator.flake = false;

    # robotnix.url = "github:danielfullmer/robotnix";

    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    # emacs-overlay.flake = false;

    # doom-emacs.url = "github:nix-community/nix-doom-emacs";
    # doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    # doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";

    # hyprland.url = "github:vaxerski/Hyprland"; # Add "hyprland.nixosModules.default" to the host modules
    # hyprland.inputs.nixpkgs.follows = "nixpkgs";

    ### KDE Plasma user settings
    # plasma-manager.url = "github:pjones/plasma-manager"; # Add "inputs.plasma-manager.homeManagerModules.plasma-manager" to the home-manager.users.${user}.imports
    # plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    # plasma-manager.inputs.home-manager.follows = "nixpkgs";

    # budgie.url = "github:FedericoSchonborn/budgie-nix";
    # budgie.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    self,
    nix-formatter-pack,
    nixpkgs,
    vscode-server,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    libx = import ./lib {inherit inputs outputs stateVersion;};
  in {
    # home-manager switch -b backup --flake $HOME/Zero/nix-config
    # nix build .#homeConfigurations."juca@ripper".activationPackage
    homeConfigurations = {
      # .iso images
      "juca@iso-console" = libx.mkHome {
        hostname = "iso-console";
        username = "nixos";
      };
      "juca@iso-desktop" = libx.mkHome {
        hostname = "iso-desktop";
        username = "nixos";
        desktop = "pantheon";
      };
      # Workstations
      "juca@designare" = libx.mkHome {
        hostname = "designare";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@micropc" = libx.mkHome {
        hostname = "micropc";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@p1" = libx.mkHome {
        hostname = "p1";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@p2-max" = libx.mkHome {
        hostname = "p2-max";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@ripper" = libx.mkHome {
        hostname = "ripper";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@trooper" = libx.mkHome {
        hostname = "trooper";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@vm" = libx.mkHome {
        hostname = "vm";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@win2" = libx.mkHome {
        hostname = "win2";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@win-max" = libx.mkHome {
        hostname = "win-max";
        username = "juca";
        desktop = "pantheon";
      };
      "juca@zed" = libx.mkHome {
        hostname = "zed";
        username = "juca";
        desktop = "pantheon";
      };
      # Servers
      "juca@brix" = libx.mkHome {
        hostname = "brix";
        username = "juca";
      };
      "juca@skull" = libx.mkHome {
        hostname = "skull";
        username = "juca";
      };
      "juca@vm-mini" = libx.mkHome {
        hostname = "vm-mini";
        username = "juca";
      };
      # Steam Deck
      "deck@steamdeck" = libx.mkHome {
        hostname = "steamdeck";
        username = "deck";
      };
      # Laptops
      "juca@air" = libx.mkHome {
        hostname = "air";
        username = "juca";
        desktop = "mate";
      };
      "juca@debianvm" = libx.mkHome {
        hostname = "debianvm";
        username = "juca";
        desktop = "budgie";
      };
      "juca@hyperv" = libx.mkHome {
        hostname = "hyperv";
        username = "juca";
        desktop = "mate";
      };
      "junior@archnitro" = libx.mkHome {
        hostname = "archnitro";
        username = "juca";
      };
      # WSL
      "juca@nitrowin" = libx.mkHome {
        hostname = "nitrowin";
        username = "juca";
      };
    };
    nixosConfigurations = {
      # .iso images
      #  - nix build .#nixosConfigurations.{iso-console|iso-desktop}.config.system.build.isoImage
      iso-console = libx.mkHost {
        hostname = "iso-console";
        username = "nixos";
        installer = nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix";
      };
      iso-desktop = libx.mkHost {
        hostname = "iso-desktop";
        username = "nixos";
        installer = nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
        desktop = "pantheon";
      };
      iso-micropc = libx.mkHost {
        hostname = "micropc";
        username = "nixos";
        installer = nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
        desktop = "pantheon";
      };
      iso-win2 = libx.mkHost {
        hostname = "win2";
        username = "nixos";
        installer = nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
        desktop = "pantheon";
      };
      iso-win-max = libx.mkHost {
        hostname = "iso-win-max";
        username = "nixos";
        installer = nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
        desktop = "pantheon";
      };
      # Workstations
      #  - sudo nixos-rebuild switch --flake $HOME/Zero/nix-config
      #  - nix build .#nixosConfigurations.ripper.config.system.build.toplevel
      designare = libx.mkHost {
        hostname = "designare";
        username = "juca";
        desktop = "pantheon";
      };
      p1 = libx.mkHost {
        hostname = "p1";
        username = "juca";
        desktop = "pantheon";
      };
      p2-max = libx.mkHost {
        hostname = "p2-max";
        username = "juca";
        desktop = "pantheon";
      };
      micropc = libx.mkHost {
        hostname = "micropc";
        username = "juca";
        desktop = "pantheon";
      };
      ripper = libx.mkHost {
        hostname = "ripper";
        username = "juca";
        desktop = "pantheon";
      };
      trooper = libx.mkHost {
        hostname = "trooper";
        username = "juca";
        desktop = "pantheon";
      };
      vm = libx.mkHost {
        hostname = "vm";
        username = "juca";
        desktop = "pantheon";
      };
      win2 = libx.mkHost {
        hostname = "win2";
        username = "juca";
        desktop = "pantheon";
      };
      win-max = libx.mkHost {
        hostname = "win-max";
        username = "juca";
        desktop = "pantheon";
      };
      zed = libx.mkHost {
        hostname = "zed";
        username = "juca";
        desktop = "pantheon";
      };
      # Servers
      brix = libx.mkHost {
        hostname = "brix";
        username = "juca";
      };
      skull = libx.mkHost {
        hostname = "skull";
        username = "juca";
      };
      vm-mini = libx.mkHost {
        hostname = "vm-mini";
        username = "juca";
      };
      # Laptops
      "juca@air" = libx.mkHost {
        hostname = "air";
        username = "juca";
        desktop = "mate";
      };
      "juca@debianvm" = libx.mkHost {
        hostname = "debianvm";
        username = "juca";
        desktop = "budgie";
      };
      "juca@hyperv" = libx.mkHost {
        hostname = "hyperv";
        username = "juca";
        desktop = "mate";
    };

    # Devshell for bootstrapping; acessible via 'nix develop' or 'nix-shell' (legacy)
    devShells = libx.forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    # nix fmt
    formatter = libx.forAllSystems (
      system:
        nix-formatter-pack.lib.mkFormatter {
          pkgs = nixpkgs.legacyPackages.${system};
          config.tools = {
            alejandra.enable = true;
            deadnix.enable = true;
            nixpkgs-fmt.enable = false;
            statix.enable = true;
          };
        }
    );

    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Custom packages; acessible via 'nix build', 'nix shell', etc
    packages = libx.forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs;}
    );
  };
}
