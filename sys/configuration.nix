{ pkgs, vars, ... }: {
  # External modules.
  # System directory component declarations.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # Platform domain.
  # System profile resource specifications.
  environment = {
    # System software.
    # Globally accessible binary packages.
    systemPackages = with pkgs; [ ];

    # Runtime parameters.
    # System environment variable definitions.
    sessionVariables = {
      # Graphics vendor.
      # NVIDIA driver platform assignment.
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      # Acceleration mode.
      # Direct hardware decode backend.
      NVD_BACKEND = "direct";
    };
  };

  # System scope.
  # Machine platform lifecycle architecture.
  system = {
    # Automatic upgrades.
    # Scheduled system rebuild routine.
    autoUpgrade = {
      # Activation state.
      # Background daemon execution switch.
      enable = true;

      # Execution interval.
      # Maintenance interval timing specification.
      dates = "weekly";

      # Target path.
      # Flake repository configuration location.
      flake = "/home/${vars.user.name}/nix-configuration#nixos";

      # Update parameters.
      # Lockfile input revision arguments.
      flags = [ "--update-input" "nixpkgs" "--update-input" "home-manager" ];

      # Automatic reboot.
      # Post-update power cycle authorization.
      allowReboot = true; # NOTE: `persistent` defaults to `true`, so missed weekly upgrades run on next boot.
    };

    # State compatibility.
    # Backwards migration release baseline.
    stateVersion = vars.stateVersion;
  };
}
