{
  # System scope.
  # Personal NixOS configuration with Hyprland tiling Wayland compositor.
  description = "Personal NixOS configuration with Hyprland tiling Wayland compositor.";

  # Input sources.
  # External dependencies for build inputs.
  inputs = {
    # Package source.
    # Unstable nixpkgs channel reference.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager.
    # User environment management system.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Build context.
  # Flake output definition.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Shared variables.
    # Central configuration values import.
    vars = import ./lib/shared-variables.nix;

    # Shared arguments.
    # Common module arguments set.
    sharedArgs = {
      inherit vars;
    };
  in {
    # Host system.
    # NixOS configuration entry.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Target system.
      # Architecture definition.
      system = vars.system;

      # Module arguments.
      # Shared configuration context.
      specialArgs = sharedArgs;

      # Module list.
      # System configuration modules.
      modules = [
        # Base system.
        # Core NixOS configuration and hardware setup.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Home setup.
        # Home Manager integration for user environment.
        home-manager.nixosModules.home-manager {
          # Package sharing.
          # Unified package set between system and user.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Module arguments.
          # Shared context for Home Manager.
          home-manager.extraSpecialArgs = sharedArgs;

          # User configuration.
          # Home Manager user profile definition.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
