{
  # Project metadata.
  # Complete system scope summary.
  description = "Personal NixOS configuration with Hyprland and Caelestia shell dotfiles.";

  # External dependencies.
  # Flake channel input sources.
  inputs = {
    # Package repository.
    # Official NixOS distribution URL.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # User environment.
    # Framework input channel source.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Target outputs.
  # Evaluated system build specifications.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Shared variables.
    # Global configuration parameter set.
    vars = import ./lib/shared-variables.nix {
      inherit (nixpkgs) lib;
    };

    # Context map.
    # System-wide argument delivery vector.
    sharedArgs = {
      inherit vars;
    };
  in {
    # Host configurations.
    # Target machine deployment specifications.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Argument propagation.
      # Global context parameter injection.
      specialArgs = sharedArgs;

      # System modules.
      # Modular component definition list.
      modules = [
        # System entrypoints.
        # Essential machine specification files.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Environment integration.
        # User space module wrapper.
        home-manager.nixosModules.home-manager {
          # Package inheritance.
          # Global software store reuse.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Variable scope.
          # Argument map injection rule.
          home-manager.extraSpecialArgs = sharedArgs;

          # Backup extension.
          # File collision safety suffix.
          home-manager.backupFileExtension = "backup";

          # User entrypoint.
          # Profile configuration file path.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
