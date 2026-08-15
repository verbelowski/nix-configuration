{ vars, ... }: {
  # Package manager.
  # Nix engine subsystem configuration.
  nix = {
    # Channel synchronization.
    # Imperative state management mechanism.
    channel.enable = false;

    # Garbage collection.
    # Automatic store cleanup routine.
    gc = {
      # Automated execution.
      # Scheduled cleanup trigger status.
      automatic = true;

      # Execution schedule.
      # Maintenance interval timing specification.
      dates = "weekly";

      # Removal parameters.
      # Deletion retention threshold flags.
      options = "--delete-older-than 14d";
    };

    # Core settings.
    # Package manager daemon parameters.
    settings = {
      # Experimental capabilities.
      # Unstable CLI feature flags.
      experimental-features = [ "nix-command" "flakes" ];

      # Privileged accounts.
      # Daemon access level boundaries.
      trusted-users = [ vars.user.name ];

      # Connection threshold.
      # Remote binary cache timeout.
      connect-timeout = 5;

      # Fallback mechanism.
      # Source compilation secondary path.
      fallback = true;

      # Binary caches.
      # Prebuilt package archive mirrors.
      substituters = [ "https://nix-community.cachix.org" ];

      # Cryptographic keys.
      # Signature verification public tokens.
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];

      # Repository status.
      # Uncommitted workspace state alerts.
      warn-dirty = false;

      # Store optimization.
      # Hardlink deduplication mechanism.
      auto-optimise-store = true;

      # Minimum threshold.
      # Storage limit allocation floor.
      min-free = 128000000;

      # Maximum threshold.
      # Storage limit allocation ceiling.
      max-free = 1000000000;
    };
  };

  # Unfree software.
  # Proprietary license policy exemption.
  nixpkgs.config.allowUnfree = true;

  # System documentation.
  # Offline reference manual generation.
  documentation.enable = false;
}
