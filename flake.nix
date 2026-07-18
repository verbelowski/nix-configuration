{
  # Project metadata.
  # Flake description strings.
  description = "Personal NixOS configuration with Hyprland and Caelestia shell dotfiles.";

  # External sources.
  # Flake dependency definitions.
  inputs = {
    # Core repository.
    # System package set sources.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # User space.
    # Home Manager environment modules.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Build targets.
  # System configuration output definitions.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Global constants.
    # Central value definitions.
    vars = import ./lib/shared-variables.nix {
      inherit (nixpkgs) lib;
    };

    # Context parameters.
    # Common module argument set definitions.
    sharedArgs = {
      inherit vars;
    };
  in {
    # Operating system.
    # Host configuration entry definitions.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Scope variables.
      # Shared context for system modules.
      specialArgs = sharedArgs;

      # Component list.
      # System and user configurations.
      modules = [
        # Architecture layers.
        # System and hardware definitions.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Personal scope.
        # User environment integration layers.
        home-manager.nixosModules.home-manager {
          # Software distribution.
          # System-wide binary sets with user package enablement.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Environment parameters.
          # Shared context for user modules.
          home-manager.extraSpecialArgs = sharedArgs;

          # Backup configuration.
          # Global file conflict resolution suffix.
          home-manager.backupFileExtension = "backup";

          # Profile integration.
          # Home environment definition imports.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
