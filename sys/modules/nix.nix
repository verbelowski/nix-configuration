{ vars, ... }: {
  # Package manager.
  # Nix engine subsystem configuration.
  nix = {
    # Imperative channels.
    # Path state management toggle.
    channel.enable = false;

    # Store cleanup.
    # Garbage collector schedule settings.
    gc = {
      # Maintenance trigger.
      # Automated routine execution status.
      automatic = true; # NOTE: `persistent` defaults to `true`, so missed biweekly garbage collections run on next boot.

      # Execution interval.
      # Periodic maintenance timing rule.
      dates = "weekly";

      # Retention criteria.
      # Generation deletion age threshold.
      options = "--delete-older-than 14d";
    };

    # Engine parameters.
    # Nix daemon options block.
    settings = {
      # Feature flags.
      # Experimental engine capability switches.
      experimental-features = [ "nix-command" "flakes" ];

      # Privileged accounts.
      # Administrative daemon access list.
      trusted-users = [ vars.user.name ];

      # Mirror timeout.
      # Binary cache response limit.
      connect-timeout = 5;

      # Build fallback.
      # Secondary path compilation authorization.
      fallback = true;

      # Package mirrors.
      # Binary download location URLs.
      substituters = [ "https://nix-community.cachix.org" ];

      # Download verification.
      # Cache signature public tokens.
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];

      # Repository alerts.
      # Uncommitted workspace status notifications.
      warn-dirty = false;

      # Store deduplication.
      # Disk space reduction process.
      auto-optimise-store = true;

      # Minimum boundary.
      # Storage allocation floor limit.
      min-free = 128000000;

      # Maximum boundary.
      # Storage allocation ceiling limit.
      max-free = 1000000000;
    };
  };

  # Proprietary software.
  # Unfree license policy exemption.
  nixpkgs.config.allowUnfree = true;

  # Manual generation.
  # System documentation build switch.
  documentation.enable = false;
}
