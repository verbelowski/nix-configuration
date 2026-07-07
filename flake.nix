{
  # Flake metadata.
  # Project description string.
  description = "Personal NixOS configuration with Hyprland tiling Wayland compositor.";

  # Flake inputs.
  # External source and dependency definitions.
  inputs = {
    # Nixpkgs input.
    # System package set source.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Home Manager input.
    # User environment management module.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs.
  # System configuration output definitions.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Shared variables.
    # Central configuration value definitions.
    vars = import ./lib/shared-variables.nix {
      inherit (nixpkgs) lib;
    };

    # Shared arguments.
    # Common module argument set definition.
    sharedArgs = {
      inherit vars;
    };
  in {
    # NixOS system.
    # Host configuration entry definition.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Module arguments.
      # Shared context for all system modules.
      specialArgs = sharedArgs;

      # Module list.
      # System and user configuration modules.
      modules = [
        # Module entries.
        # System and hardware configuration files.
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix

        # Home Manager module.
        # User environment integration layer.
        home-manager.nixosModules.home-manager {
          # Package management mode.
          # System-wide package set with user package enablement.
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Home Manager arguments.
          # Shared configuration context for user modules.
          home-manager.extraSpecialArgs = sharedArgs;

          # User configuration entry.
          # Home environment definition import.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
