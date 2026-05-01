{ ... }: {
  # SSH configuration.
  # Program entry definition.
  programs.ssh = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Default override.
    # Legacy SSH configuration generation.
    enableDefaultConfig = false;

    # Host matching rules.
    # Per-host connection settings.
    matchBlocks = {
      "*" = {
        # Identity restriction.
        # Key usage limited to explicit identities.
        identitiesOnly = true;

        # Keep-alive policy.
        # Periodic reachability checks and failure tolerance.
        serverAliveInterval = 60;
        serverAliveCountMax = 3;

        # SSH agent integration.
        # Automatic key addition to agent.
        addKeysToAgent = "yes";
      };

      "github.com" = {
        # Remote user.
        # Account for Git operations.
        user = "git";

        # Authentication key.
        # Identity file for repository access.
        identityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
