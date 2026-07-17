{ vars, ... }: {
  # Package management.
  # Nix daemon configurations.
  nix = {
    # Source tracking.
    # Legacy channel system state.
    channel.enable = false;

    # Space reclamation.
    # Automatic old generation removal settings.
    gc = {
      # Enablement flag.
      # Automatic garbage collection state.
      automatic = true;

      # Execution schedule.
      # Weekly collection interval definitions.
      dates = "weekly";

      # Removal options.
      # Generation age deletion threshold.
      options = "--delete-older-than 7d";
    };

    # Daemon settings.
    # Store and build options.
    settings = {
      # Modern capabilities.
      # Flakes and new CLI command enablement.
      experimental-features = [ "nix-command" "flakes" ];

      # Privileged accounts.
      # Trusted Nix operation access list.
      trusted-users = [ vars.user.name ];

      # Request timeout.
      # Binary cache connection time limit in seconds.
      connect-timeout = 5;

      # Compilation fallback.
      # Source build on binary cache failure.
      fallback = true;

      # Repository warnings.
      # Git tree modification alert state.
      warn-dirty = false;

      # Capacity optimisation.
      # Automatic hard link deduplication state.
      auto-optimise-store = true;

      # Minimum capacity.
      # Garbage collection trigger threshold in bytes.
      min-free = 128000000;

      # Maximum capacity.
      # Garbage collection target threshold in bytes.
      max-free = 1000000000;
    };
  };

  # Repository configurations.
  # Unfree package installation allowance.
  nixpkgs.config.allowUnfree = true;

  # Manual pages.
  # System documentation generation state.
  documentation.enable = false;
}
