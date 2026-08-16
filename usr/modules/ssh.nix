{ ... }: {
  # Secure shell.
  # Encrypted remote access protocol.
  programs.ssh = {
    # SSH activation.
    # Encrypted connection client switch.
    enable = true;

    # Default configuration.
    # Standard client settings switch.
    enableDefaultConfig = false;

    # Host options.
    # Connection lookup table.
    settings = {
      # Wildcard matching.
      # Global connection default rules.
      "*" = {
        # Agent forwarding.
        # Key delegation security policy.
        ForwardAgent = false;

        # Identity restriction.
        # Explicit key file enforcement.
        IdentitiesOnly = true;

        # Host hashing.
        # Obfuscated server registry switch.
        HashKnownHosts = false;

        # Known hosts.
        # Trusted server key storage.
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Keepalive parameters.
        # Connection probe frequency bounds.
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;

        # Agent integration.
        # Automatic key loading policy.
        AddKeysToAgent = "yes";
      };

      # GitHub host.
      # Code platform authentication parameters.
      "github.com" = {
        # Service account.
        # Remote platform login identifier.
        User = "git";

        # Authentication key.
        # Private credential file path.
        IdentityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
