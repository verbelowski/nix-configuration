{
  # System scope.
  # Personal NixOS configuration with Hyprland tiling Wayland compositor.
  description = "Personal NixOS configuration with Hyprland tiling Wayland compositor.";

  # Input sources.
  # External dependencies and flake inputs.
  inputs = {
    # Package source.
    # Unstable nixpkgs channel reference.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager.
    # User environment management layer.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Build context.
  # Flake outputs and build definition.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Shared variables.
    # External constant definitions.
    vars = import ./lib/shared-variables.nix;

    # Shared context.
    # Common argument set for modules and Home Manager.
    sharedArgs = {
      inherit vars;
    };
  in {
    # Host configuration.
    # Build definition for machine.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Target platform.
      # Linux architecture definition.
      system = vars.system;

      # Argument context.
      # Shared arguments available to modules.
      specialArgs = sharedArgs;

      # Module composition.
      # Module list and structure.
      modules = [
        # Base setup.
        # Core system and hardware definitions.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Home integration.
        # Home Manager binding layer.
        home-manager.nixosModules.home-manager {
          # Package alignment.
          # Shared packages and user-level installs.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Argument context.
          # Shared arguments available to Home Manager.
          home-manager.extraSpecialArgs = sharedArgs;

          # User setup.
          # Home Manager entrypoint for user environment.
          home-manager.users.${vars.username} = import ./usr/home.nix;
        }
      ];
    };
  };
}
