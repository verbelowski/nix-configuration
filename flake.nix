{
  # Flake metadata.
  # Project description.
  description = "Personal NixOS configuration with Hyprland tiling Wayland compositor.";

  # Flake inputs.
  # External sources and dependencies.
  inputs = {
    # Nixpkgs input.
    # System package set.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Home Manager input.
    # User environment module.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs.
  # System configuration definitions.
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    # Shared variables.
    # Central configuration values.
    vars = import ./lib/global-variables.nix;

    # Shared arguments.
    # Common module argument set.
    sharedArgs = {
      inherit vars;
    };
  in {
    # NixOS system.
    # Host configuration entry.
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      # Module arguments.
      # Shared context for all modules.
      specialArgs = sharedArgs;

      # Module list.
      # System and user modules.
      modules = [
        # Module entries.
        # System and hardware files.
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
          # Shared configuration context.
          home-manager.extraSpecialArgs = sharedArgs;

          # User configuration entry.
          # Home environment definition.
          home-manager.users.${vars.user.name} = import ./usr/home.nix;
        }
      ];
    };
  };
}
