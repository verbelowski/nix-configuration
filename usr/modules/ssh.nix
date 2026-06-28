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
    settings = {
      "*" = {
        # Agent forwarding.
        # Disabled for security.
        ForwardAgent = false;

        # Identity restriction.
        # Key usage limited to explicit identities.
        IdentitiesOnly = true;

        # Known hosts hashing.
        # Unobfuscated host entries for readability.
        HashKnownHosts = false;

        # Known hosts path.
        # Default location for known hosts file.
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Keep-alive policy.
        # Periodic reachability checks and failure tolerance.
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;

        # SSH agent integration.
        # Automatic key addition to agent.
        AddKeysToAgent = "yes";
      };

      "github.com" = {
        # Remote user.
        # Account for Git operations.
        User = "git";

        # Authentication key.
        # Identity file for repository access.
        IdentityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
