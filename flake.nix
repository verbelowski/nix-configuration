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
    # Configuration parameter definition set.
    vars = import ./lib/shared-variables.nix {
      inherit (nixpkgs) lib;
    };

    # Context propagation.
    # Shared argument attribute map.
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
          # Integration options.
          # User space environment attributes.
          home-manager = {
            # Package inheritance.
            # Global software store reuse.
            useGlobalPkgs = true;
            useUserPackages = true;

            # Variable scope.
            # Argument map injection rule.
            extraSpecialArgs = sharedArgs;

            # Backup extension.
            # File collision safety suffix.
            backupFileExtension = "backup";

            # User entrypoint.
            # Profile configuration file path.
            users.${vars.user.name} = import ./usr/home.nix;
          };
        }
      ];
    };
  };
}
