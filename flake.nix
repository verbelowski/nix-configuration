{
  # Project scope.
  # System configuration context.
  description = "Personal NixOS configuration with Hyprland tiling Wayland compositor.";

  # Input sources.
  # External dependency definitions.
  inputs = {
    # Package source.
    # NixOS package collection reference.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager.
    # User environment management setup.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Output configuration.
  # System build definitions.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Shared variables.
    # Common configuration values import.
    vars = import ./lib/shared-variables.nix;

    # Shared arguments.
    # Global parameter collection.
    sharedArgs = {
      inherit vars;
    };
  in {
    # System configurations.
    # Machine build definitions.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # System target.
      # Architecture selection value.
      system = vars.system;

      # Special arguments.
      # Global parameter set for modules.
      specialArgs = sharedArgs;

      # Module list.
      # System configuration composition.
      modules = [
        # System configuration.
        # Core operating system and hardware definitions.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Home Manager integration.
        # User environment configuration.
        home-manager.nixosModules.home-manager {
          # Package usage.
          # Global package set and user package installation settings.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Extra arguments.
          # Additional configuration inputs.
          home-manager.extraSpecialArgs = sharedArgs;

          # User configuration.
          # Home environment definition.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
