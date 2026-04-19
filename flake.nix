{
  # System scope.
  # Personal NixOS configuration with Hyprland tiling Wayland compositor.
  description = "Personal NixOS configuration with Hyprland tiling Wayland compositor.";

  # Input sources.
  # External dependencies and inputs.
  inputs = {
    # Package source.
    # Unstable nixpkgs channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager.
    # User environment management layer.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Build context.
  # Flake outputs definition.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Shared variables.
    # External values.
    vars = import ./lib/shared-variables.nix;

    # Shared context.
    # Module arguments set.
    sharedArgs = {
      inherit vars;
    };
  in {
    # Host configuration.
    # System build definition.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Target platform.
      # System architecture.
      system = vars.system;

      # Argument context.
      # Module shared arguments.
      specialArgs = sharedArgs;

      # Module composition.
      # System module set.
      modules = [
        # Base setup.
        # System configuration and hardware.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Home integration.
        # Home Manager layer.
        home-manager.nixosModules.home-manager {
          # Package alignment.
          # Global package sharing.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Argument context.
          # Home Manager shared arguments.
          home-manager.extraSpecialArgs = sharedArgs;

          # User setup.
          # Home Manager user configuration.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
