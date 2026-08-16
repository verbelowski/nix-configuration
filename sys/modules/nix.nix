{ vars, ... }: {
  # Package manager.
  # Nix engine subsystem configuration.
  nix = {
    # Channel usage.
    # Imperative path state management.
    channel.enable = false;

    # Store cleanup.
    # Space reclamation routine settings.
    gc = {
      # Automated routine.
      # Scheduled maintenance execution switch.
      automatic = true; # NOTE: `persistent` defaults to `true`, so missed biweekly garbage collections run on next boot.

      # Maintenance schedule.
      # Periodic execution interval rule.
      dates = "weekly";

      # Retention threshold.
      # Generation deletion criteria flags.
      options = "--delete-older-than 14d";
    };

    # System settings.
    # Nix daemon configuration parameters.
    settings = {
      # Feature flags.
      # Experimental engine capability switches.
      experimental-features = [ "nix-command" "flakes" ];

      # Privileged accounts.
      # Administrative user access list.
      trusted-users = [ vars.user.name ];

      # Remote timeout.
      # Binary mirror connection limit.
      connect-timeout = 5;

      # Cache fallback.
      # Secondary build path authorization.
      fallback = true;

      # Binary mirrors.
      # Package download endpoint URLs.
      substituters = [ "https://nix-community.cachix.org" ];

      # Public keys.
      # Download signature verification tokens.
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];

      # Repository status.
      # Uncommitted workspace modification alerts.
      warn-dirty = false;

      # Store optimization.
      # Disk space deduplication process.
      auto-optimise-store = true;

      # Minimum boundary.
      # Storage allocation floor limit.
      min-free = 128000000;

      # Maximum boundary.
      # Storage allocation ceiling limit.
      max-free = 1000000000;
    };
  };

  # Unfree software.
  # Proprietary license policy exemption.
  nixpkgs.config.allowUnfree = true;

  # Manual generation.
  # System documentation build switch.
  documentation.enable = false;
}
