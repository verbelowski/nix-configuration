{ vars, ... }: {
  # Package management.
  # Nix daemon configurations.
  nix = {
    # Source tracking.
    # Legacy channel system states.
    channel.enable = false;

    # Space reclamation.
    # Automatic old generation removal settings.
    gc = {
      # Enablement state.
      # Automatic garbage collection flags.
      automatic = true;

      # Execution schedule.
      # Weekly collection interval definitions.
      dates = "weekly";

      # Retention options.
      # Generation age deletion thresholds.
      options = "--delete-older-than 7d";
    };

    # Daemon settings.
    # Store and build options.
    settings = {
      # Modern capabilities.
      # Flakes and new CLI command enablement.
      experimental-features = [ "nix-command" "flakes" ];

      # Privileged accounts.
      # Trusted Nix operation access lists.
      trusted-users = [ vars.user.name ];

      # Request timeout.
      # Binary cache connection time limits.
      connect-timeout = 5;

      # Compilation fallback.
      # Source build on binary cache failures.
      fallback = true;

      # Binary caches.
      # External store fetch sources.
      substituters = [ "https://nix-community.cachix.org" ];

      # Public keys.
      # Trusted store verification material.
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];

      # Repository warnings.
      # Git tree modification alert states.
      warn-dirty = false;

      # Capacity optimization.
      # Automatic hard link deduplication states.
      auto-optimise-store = true;

      # Minimum capacity.
      # Garbage collection trigger threshold bytes.
      min-free = 128000000;

      # Maximum capacity.
      # Garbage collection target threshold bytes.
      max-free = 1000000000;
    };
  };

  # Repository configuration.
  # Unfree package installation allowances.
  nixpkgs.config.allowUnfree = true;

  # Help resources.
  # System documentation generation states.
  documentation.enable = false;
}
