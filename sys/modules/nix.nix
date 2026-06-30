{ vars, ... }: {
  # Nix configuration.
  # Package manager settings.
  nix = {
    # Channel management.
    # Legacy channel system state.
    channel.enable = false;

    # Garbage collection.
    # Automatic old generation removal settings.
    gc = {
      # Enable flag.
      # Automatic garbage collection state.
      automatic = true;

      # Schedule.
      # Weekly collection interval definition.
      dates = "weekly";

      # Collection options.
      # Generation age removal threshold.
      options = "--delete-older-than 7d";
    };

    # Nix settings.
    # Store and build configuration options.
    settings = {
      # Experimental features.
      # Flakes and new CLI command enablement.
      experimental-features = [ "nix-command" "flakes" ];

      # Trusted users.
      # Privileged Nix operation access list.
      trusted-users = [ vars.user.name ];

      # Connection timeout.
      # Binary cache connection time limit in seconds.
      connect-timeout = 5;

      # Fallback builds.
      # Source build fallback on binary cache failure.
      fallback = true;

      # Dirty warning.
      # Git tree modification warning state.
      warn-dirty = false;

      # Store optimisation.
      # Automatic hard link deduplication state.
      auto-optimise-store = true;

      # Minimum free space.
      # Garbage collection trigger threshold in bytes.
      min-free = 128000000;

      # Maximum free space.
      # Garbage collection target threshold in bytes.
      max-free = 1000000000;
    };
  };

  # Nixpkgs configuration.
  # Unfree package installation allowance.
  nixpkgs.config.allowUnfree = true;

  # NixOS documentation.
  # System documentation generation state.
  documentation.enable = false;
}
