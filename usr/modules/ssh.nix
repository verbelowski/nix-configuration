{ ... }: {
  # Secure shell.
  # Encrypted remote access protocol.
  programs.ssh = {
    # Activation state.
    # Connection client switch.
    enable = true;

    # Standard settings.
    # Default client options toggle.
    enableDefaultConfig = false;

    # Option configuration.
    # Connection lookup table.
    settings = {
      # Wildcard pattern.
      # Global connection default rules.
      "*" = {
        # Identity restriction.
        # Key file enforcement flag.
        IdentitiesOnly = true;

        # Host obfuscation.
        # Server registry hash toggle.
        HashKnownHosts = true;

        # Known hosts.
        # Trusted server key storage.
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Connection probes.
        # Keep-alive packet transmission frequency.
        ServerAliveInterval = 60;

        # Agent integration.
        # Background key import policy.
        AddKeysToAgent = "yes";
      };

      # Platform host.
      # Code repository authentication parameters.
      "github.com" = {
        # Service account.
        # Remote platform login identifier.
        User = "git";

        # Key location.
        # Private credential file path.
        IdentityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
