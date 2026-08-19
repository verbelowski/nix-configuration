{
  # Project metadata.
  # Declarative system scope summary.
  description = "Personal NixOS configuration with Hyprland and Caelestia shell dotfiles.";

  # External dependencies.
  # Flake channel input sources.
  inputs = {
    # Package repository.
    # Official NixOS distribution URL.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # User environment.
    # Dotfile management framework source.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Target outputs.
  # Evaluated system build specifications.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Global parameters.
    # Shared configuration variable set.
    vars = import ./lib/shared-variables.nix {
      inherit (nixpkgs) lib;
    };

    # Module arguments.
    # System-wide context variable map.
    sharedArgs = {
      inherit vars;
    };
  in {
    # Host configurations.
    # Declarative machine deployment specifications.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Context propagation.
      # Global module parameter delivery.
      specialArgs = sharedArgs;

      # System modules.
      # Declarative component definition list.
      modules = [
        # System entrypoints.
        # Essential machine specification files.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Environment integration.
        # User space module wrapper.
        home-manager.nixosModules.home-manager {
          # Package scope.
          # Global inheritance flags.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Variable scope.
          # Scope argument injection.
          home-manager.extraSpecialArgs = sharedArgs;

          # Backup extension.
          # File collision safety suffix.
          home-manager.backupFileExtension = "backup";

          # User entrypoint.
          # Profile configuration path.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
